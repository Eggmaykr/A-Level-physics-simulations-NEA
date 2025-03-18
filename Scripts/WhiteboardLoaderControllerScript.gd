extends Control

var WhiteBoardName = "Default"


func _on_NewWhiteboard_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			get_node("CreateNew").show()


func _on_LastWhiteboard_gui_input(event):
	pass # Replace with function body.


func _on_LoadWhiteboard_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			get_node("LoadWhiteboard").show()
			var whiteboards = Database.run_custom_query("SELECT UnqBoardID, DateCreated FROM Whiteboards")
			for whiteboard in whiteboards:
				var whiteboardinstance = load("res://ExperimentParts/LoadWhiteboard.tscn").instance()
				whiteboardinstance.UnqBoardID = whiteboard["UnqBoardID"]
				get_node("LoadWhiteboard/NewWhiteboard/LoadScroll/LoadGrid").add_child(whiteboardinstance)
				var LastChild = get_node("LoadWhiteboard/NewWhiteboard/LoadScroll/LoadGrid").get_child_count()-1
				get_node("LoadWhiteboard/NewWhiteboard/LoadScroll/LoadGrid").get_child(LastChild).get_node("NameLabel").text = str(whiteboard["UnqBoardID"])
				get_node("LoadWhiteboard/NewWhiteboard/LoadScroll/LoadGrid").get_child(LastChild).get_node("DateLabel").text = whiteboard["DateCreated"]


func _on_Cancel_pressed():
	get_node("CreateNew").hide()

func _on_CancelLoad_pressed():
	get_node("LoadWhiteboard").hide()

func _on_CreateNewConfirm_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			if WhiteBoardName != "":
				var time_created = OS.get_datetime()
				var converted_time_created = str(time_created["year"]) + "/" + str(time_created["month"]) + "/" + str(time_created["day"]) + "-" + str(time_created["hour"]) + ":" +str(time_created["minute"])
				var data = {"BoardName" : WhiteBoardName, "DateCreated" : converted_time_created}
				Database.write_to_database("Whiteboards", data)
				Database.CurrentWhiteBoardID = Database.get_size_of_table("Whiteboards", "UnqBoardID")
				print(Database.CurrentWhiteBoardID)
				get_tree().change_scene("res://MainGUI/Board.tscn")


func _on_LineEdit_text_changed(new_text):
	WhiteBoardName = new_text

func initiateWhiteboardLoading(BoardID):
	Database.CurrentWhiteBoardID = BoardID
	Database.Loading = true
	get_tree().change_scene("res://MainGUI/Board.tscn")

