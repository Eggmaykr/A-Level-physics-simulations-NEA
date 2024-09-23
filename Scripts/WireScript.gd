extends Line2D

func _Set_Up(pos1, pos2):
	add_point(pos1, 0)
	add_point(pos2, 1)
	return self
