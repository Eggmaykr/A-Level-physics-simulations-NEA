extends Panel

export var Is_Reciever : bool = false 
export var method_connected = ""
var Connected_Reciever = null
var Wire_Connected = null

func _activate_Reciever(Parameter):
	return get_parent().get_node("Main/Experiment").call(method_connected, Parameter)

func _activate_Sender(Parameter):
	return Connected_Reciever._activate_Reciever(Parameter)

func _on_WireConnection_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true and Is_Reciever == false:
			if Wire_Connected != null:
				Wire_Connected.queue_free()
				Wire_Connected = null
			_Create_Wire()
		elif event.pressed == false and Is_Reciever == true:
			get_parent().get_parent().get_parent().get_node("HelloThere")._Connect_Wire(self)

func _Create_Wire():
	var WireInst = load("res://MainGUI/Wire.tscn").instance()
	WireInst._Set_Up(self)
	get_parent().get_parent().get_parent().get_node("Items").add_child(WireInst)

func _Connect_Wire(Wire):
	Wire_Connected = Wire
	get_parent().get_parent().get_parent().get_node("HelloThere").Wiring = Wire
