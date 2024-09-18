extends Camera2D

var FingerIndexes = []
var VelocityVector : Vector2 = Vector2.ZERO
var CurrentSelected = ""

var Wiring = null

# warning-ignore:unused_argument
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		position -= event.relative


func _on_Experiments_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			if CurrentSelected != "Experiment":
				if CurrentSelected != "":
					get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play_backwards("OpenClose" + CurrentSelected)
					CurrentSelected = "Experiment"
				else:
					CurrentSelected = "Experiment"
					get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play("OpenClose" + CurrentSelected)
			else:
				get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play_backwards("OpenClose" + CurrentSelected)
				CurrentSelected = ""



func _on_Opener_animation_finished(anim_name):
	if anim_name != "OpenClose"+CurrentSelected and CurrentSelected != "":
		get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play("OpenClose"+CurrentSelected)


func _on_Tools_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			if CurrentSelected != "Tools":
				if CurrentSelected != "":
					get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play_backwards("OpenClose" + CurrentSelected)
					CurrentSelected = "Tools"
				else:
					CurrentSelected = "Tools"
					get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play("OpenClose" + CurrentSelected)
			else:
				get_node("CanvasLayer").get_node(CurrentSelected).get_node("Opener").play_backwards("OpenClose" + CurrentSelected)
				CurrentSelected = ""
