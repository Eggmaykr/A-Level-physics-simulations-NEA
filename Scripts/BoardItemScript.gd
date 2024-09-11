extends Node2D

var Open = false
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
