extends Node2D
var Open : bool = false
var Moving : bool = false
var Selected : bool = false
var Instantiated : bool = false
export var PathToSelf : String = ""
var UniqSelfID : int = 0

func _ready():
	if Instantiated == false: #this selection writes a newly placed object to the database
		var SettingsDefaults = get_node("Main/Experiment").get_defaults()
		Database.write_to_database("WhiteboardItems",{
		"ItemName" : self.name,
		"UnqBoardID" : Database.CurrentWhiteBoardID,
		"ItemFilePath" : PathToSelf,
		"ItemSettings" : SettingsDefaults,
		"ItemPosition" : var2str(self.position)
		})
		UniqSelfID = Database.get_size_of_table("WhiteboardItems", "ItemID")
	else: #loads an object from the database
		var settingsToLoad = Database.run_custom_query("SELECT ItemSettings FROM WhiteboardItems WHERE UnqBoardID = " + str(Database.CurrentWhiteBoardID) + " and ItemID = " + str(UniqSelfID))
		print(settingsToLoad)
		get_node("Main/Experiment").load_settings(settingsToLoad[0])

func initialise(SelfID):#ran to prepare an object for loading
	UniqSelfID = SelfID
	Instantiated = true

func _on_Settings_pressed():#opens settings if present
	if Open == false:
		get_node("Expandable/Opener").play("Open_Close")
		Open = true
	else:
		get_node("Expandable/Opener").play_backwards("Open_Close")
		Open = false

func _input(event):
	if Moving == true:
		if event is InputEventScreenTouch:
			if event.pressed == false:
				Moving = false #allows object to be moved
		elif event is InputEventScreenDrag:
			self.position += event.relative
			Database.update_database("WhiteboardItems", "ItemID", UniqSelfID, {"ItemPosition" : var2str(self.position)})#moves object and udates its position in the database
		var OwnSockets = get_node("Sockets").get_children()
		for Socket in OwnSockets:
			if Socket.WireConnected:
				if Socket.Is_Reciever == true:
					Socket.WireConnected.points[1] = Socket.rect_global_position+Vector2(30,30)#moves wire when object is moved
				elif Socket.Is_Reciever == false:
					Socket.WireConnected.points[0] = Socket.rect_global_position+Vector2(30,30)#moves wire when object is moved

func _unhandled_input(event):
	if Selected == true:
		if event is InputEventScreenTouch:
			if event.pressed == false:
				if Open == true:
					if get_child_count() > 3: #opens options
						Open = false
						get_node("Expandable/Opener").play_backwards("Open_Close")
				Selected = false
				self.z_index = 0
				get_node("Selected/Opener").play_backwards("OpenClose")

func _on_Delete_pressed():
	if Open == true and get_child_count() > 3:
		for socket in get_node("Sockets").get_children():
			socket.sever_connection()#severs existing connection
		self.queue_free()
	elif Selected == true and get_child_count() == 3:
		for socket in get_node("Sockets").get_children():
			socket.sever_connection()
		self.queue_free()

func _on_Main_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Selected = true
			self.z_index = 1
			get_node("Selected/Opener").play("OpenClose")

func _on_Close_pressed():
	if Open == true:
		if get_child_count() > 3:
			Open = false
			get_node("Expandable/Opener").play_backwards("Open_Close")
	Selected = false
	self.z_index = 0
	get_node("Selected/Opener").play_backwards("OpenClose")

func _on_JoystickAnalogue_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Moving = true

