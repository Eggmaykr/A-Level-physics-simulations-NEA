extends Control





func _process(delta):
	get_node("VBoxContainer/TimeLeft").text = str(get_node("Timer").time_left)

func _on_Timer_timeout():
	pass # Replace with function body.


func _on_TouchScreenButton_pressed():
	self.queue_free()
