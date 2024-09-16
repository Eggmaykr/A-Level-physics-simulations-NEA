extends Panel

export var Scene_Path : String = ""
export var Show_Name : String = ""

var AimPoint = preload("res://MainGUI/Package.tscn")
var Dragged = false
var DragObject = null

func _ready():
	get_node("Label").text = Show_Name
func _input(event):
	if Dragged == true:
		if event is InputEventScreenTouch:
			if event.pressed == false:
				var SceneInstance = load(Scene_Path).instance()
				print(get_global_mouse_position(),get_parent().get_parent().get_parent().get_parent().get_node("Position").position,get_parent().get_parent().get_parent().get_parent().get_parent().position-get_parent().get_parent().get_parent().get_parent().get_node("Position").position)
				SceneInstance.position = get_parent().get_parent().get_parent().get_parent().get_parent().position+get_parent().get_parent().get_parent().get_parent().get_node("Position").position-(get_viewport_rect().size/2)+Vector2(-300, -300)
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Items").add_child(SceneInstance)
				get_parent().get_parent().get_parent().get_parent().get_node("Position").queue_free()
				Dragged = false

func _on_Experiments_gui_input(event):
	if event is InputEventScreenTouch:
		if Dragged == false:
			Dragged = true
			var DragObject = AimPoint.instance()
			DragObject.position = get_global_mouse_position()
			print(get_global_mouse_position())
			get_parent().get_parent().get_parent().get_parent().add_child(DragObject)
