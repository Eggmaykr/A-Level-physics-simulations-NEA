extends Node2D

var Open = false
var Moving = false
var Selected = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Settings_pressed():
	if Open == false:
		get_node("Expandable/Opener").play("Open_Close")
		Open = true
	else:
		get_node("Expandable/Opener").play_backwards("Open_Close")
		Open = false

func _input(event):
	if Moving == true:
		if event is InputEventScreenTouch:
			if event.pressed == false:
				Moving = false
		elif event is InputEventScreenDrag:
			self.position += event.relative
		var OwnSockets = get_node("Sockets").get_children()
		for Socket in OwnSockets:
			if Socket.WireConnected:
				if Socket.Is_Reciever == true:
					Socket.WireConnected.points[1] = Socket.rect_global_position+Vector2(30,30)
				elif Socket.Is_Reciever == false:
					Socket.WireConnected.points[0] = Socket.rect_global_position+Vector2(30,30)
			

func _unhandled_input(event):
	if Selected == true:
		if event is InputEventScreenTouch:
			if event.pressed == false:
				if Open == true:
					Open = false
					get_node("Expandable/Opener").play_backwards("Open_Close")
				Selected = false
				self.z_index = 0
				get_node("Selected/Opener").play_backwards("OpenClose")

func _on_Delete_pressed():
	if Open == true:
		self.queue_free()


func _on_Main_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Selected = true
			self.z_index = 1
			get_node("Selected/Opener").play("OpenClose")


func _on_Close_pressed():
	if Open == true:
		Open = false
		get_node("Expandable/Opener").play_backwards("Open_Close")
	Selected = false
	self.z_index = 0
	get_node("Selected/Opener").play_backwards("OpenClose")


func _on_JoystickAnalogue_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Moving = true



