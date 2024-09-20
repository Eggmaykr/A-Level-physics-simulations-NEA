extends Line2D

var ConnectFrom = null

func _ready():
	ConnectFrom._Connect_Wire(self)
	print(points)

func _Set_Up(Socket):
	ConnectFrom = Socket
	add_point(ConnectFrom.rect_global_position, 0)
	add_point(ConnectFrom.rect_global_position, 1)
