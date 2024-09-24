extends Control

var Repeating : bool = false


func _process(delta):
	get_node("VBoxContainer/TimeLeft").text = str(get_node("Timer").wait_time) + "/" + str(get_node("Timer").time_left)

func _on_Timer_timeout():
	get_parent().get_parent().get_node("Sockets").get_child(0)._activate_Sender(false)
	if Repeating == true:
		get_node("Timer").start(get_node("Timer").wait_time)


func _on_TouchScreenButton_pressed():
	self.queue_free()


func _on_Start_pressed():
	get_node("Timer").start(get_node("Timer").wait_time)


func _on_CheckButton_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			if Repeating == false:
				Repeating = true
				get_node("VBoxContainer/CheckButton").pressed = true
			else:
				Repeating = false
				get_node("VBoxContainer/CheckButton").pressed = false


func _on_HSlider_value_changed(value):
	get_node("Timer").stop()
	get_node("Timer").wait_time = value
	get_node("VBoxContainer/TimeLeft").text = str(value) + "/" + str(get_node("Timer").time_left)
