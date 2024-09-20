extends Camera2D

var FingerIndexes = []
var VelocityVector : Vector2 = Vector2.ZERO
var CurrentSelected = ""

var Wiring = null

# warning-ignore:unused_argument
func _input(event):
	if Wiring != null:
		if event is InputEventScreenDrag:
			Wiring.points[1] += event.relative
		elif event is InputEventScreenTouch:
			if event.pressed == false:
				Wiring.queue_free()
				Wiring = null

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		position -= event.relative
	if Wiring != null:
		if event is InputEventScreenDrag:
			Wiring.points[1] += event.relative
		elif event is InputEventScreenTouch:
			if event.pressed == false:
				Wiring.queue_free()
				Wiring = null


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


func _on_TextureRect_gui_input(event):
	if event is InputEventScreenDrag:
		zoom.x += event.relative.x/300
		zoom.x = clamp(zoom.x , 0.1, 3)
		zoom.y += event.relative.x/300
		zoom.y = clamp(zoom.y , 0.1, 3)

func _Connect_Wire(Node1):
	if Wiring.ConnectFrom != Node1:
		Wiring.ConnectFrom.Connected_Reciever = Node1
