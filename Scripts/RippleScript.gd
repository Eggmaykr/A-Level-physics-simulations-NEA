extends Panel


func _physics_process(delta):
	self.rect_position.x += 20 * delta
