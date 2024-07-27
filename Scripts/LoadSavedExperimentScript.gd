extends Panel

export var ExperimentPath = ""

func _on_Save_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true and event.button_index == BUTTON_LEFT:
			get_tree().change_scene(ExperimentPath)
