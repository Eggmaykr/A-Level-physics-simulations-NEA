extends Control

var _Input = 0.0
var _OverWrite = 0.0
var _Main_Value = 0.0

func _on_TouchScreenButton_pressed():
	self.queue_free()


func _Update(_Parameter = false):
	pass 

func _Overwrite_Parameter(Changed_Param):
	_OverWrite = Changed_Param

func _Change_Input(Changed_Param):
	_Input = Changed_Param


func _on_HSlider_value_changed(value):
	_Main_Value = value
	get_node("DataTable/Value/Name").text = "Parameter : " + str(value)
