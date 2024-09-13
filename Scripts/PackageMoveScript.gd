extends Node2D

func _ready():
	print("Spawned")
	print(self.position)

func _on_Control_gui_input(event):
	if event is InputEventScreenDrag:
		position += event.relative
