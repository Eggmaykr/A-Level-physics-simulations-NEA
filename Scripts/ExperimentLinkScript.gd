extends Panel

export var ExperimentPath : String = ""

func _on_ExperimentLink_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true and event.button_index == BUTTON_LEFT:
			get_tree().change_scene(ExperimentPath)
