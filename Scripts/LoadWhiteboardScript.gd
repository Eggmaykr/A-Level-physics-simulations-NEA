extends Panel

var UnqBoardID : int = 0

func _on_LoadItem_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			get_parent().get_parent().get_parent().get_parent().get_parent().initiateWhiteboardLoading(UnqBoardID)
