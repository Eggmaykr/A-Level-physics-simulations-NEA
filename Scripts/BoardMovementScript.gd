extends Camera2D

var FingerIndexes = []
var VelocityVector : Vector2 = Vector2.ZERO

func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		position -= event.relative
