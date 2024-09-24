extends Line2D

func _Set_Up(pos1, pos2):
	add_point(pos1+Vector2(30,30), 0)
	add_point(pos2+Vector2(30,30), 1)
	return self
