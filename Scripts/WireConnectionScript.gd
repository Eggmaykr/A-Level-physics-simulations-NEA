extends Panel

export var Is_Reciever : bool = false 
export var method_connected = ""

var WireConnected = null
var SocketConnected = null
var ConnectionStarted = false

func _activate_Reciever(Parameter):
	return get_parent().get_node("Main/Experiment").call(method_connected, Parameter)

func _activate_Sender(Parameter):
	return SocketConnected._activate_Reciever(Parameter)

func _on_WireConnection_gui_input(event):
	if event is InputEventScreenTouch:
		print(self.name, event.pressed)
		if event.pressed == true and Is_Reciever == false:
			_Start_Connection()
		elif event.pressed == true and Is_Reciever == true:
			get_parent().get_parent().get_parent().get_node("HelloThere")._Connect_Wire(self)

func _Start_Connection():
	get_parent().get_parent().get_parent().get_node("HelloThere").start_connection(self)

func _Connect_Wire(NodeCon, wire = null):
	if SocketConnected:
		SocketConnected.sever_connection()
	SocketConnected = NodeCon
	WireConnected = wire
	if Is_Reciever == true:
		var WireInst = load("res://MainGUI/Wire.tscn").instance()
		WireConnected = WireInst._Set_Up(NodeCon.rect_global_position, self.rect_global_position)
		get_parent().get_parent().get_parent().get_node("Items").add_child(WireInst)
		return WireConnected

func sever_connection():
	if WireConnected:
		WireConnected.queue_free()
		SocketConnected = null
		WireConnected = null
