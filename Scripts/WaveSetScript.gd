extends Control


func SetUP(Point : Vector2):
	get_node("Wave").add_point(Point)
	get_node("Wave2").add_point(Point)

func ChangePointWave1(PointID : int, Vector : Vector2):
	get_node("Wave").points[PointID] = Vector

func ChangePointWave2(PointID : int, Vector : Vector2):
	get_node("Wave2").points[PointID] = Vector
