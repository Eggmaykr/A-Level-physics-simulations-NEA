extends Control

var WhiteBoardName = ""


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
				var data = {"BoardName" : WhiteBoardName, "NumberOfBoardElements" : int(0), "DateCreated" : converted_time_created}
				Database.write_to_database("Whiteboards", data)
				Database.CurrentWhiteBoardID = Database.get_size_of_table("Whiteboards", "UnqBoardID")
				print(Database.CurrentWhiteBoardID)
				get_tree().change_scene("res://MainGUI/Board.tscn")


func _on_LineEdit_text_changed(new_text):
	WhiteBoardName = new_text



