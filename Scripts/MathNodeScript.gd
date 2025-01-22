extends Control

var _Input : float = 0.0
var _OverWrite : float = 0.0
var _Result : float = 0.0

enum ModeNames {ADD, SUB, MULT, DIV = 0}
var Mode : int = ModeNames.ADD

func _ready():
	get_parent().get_parent().Open = true

func _Update(_Parameter = false):
	if Mode == ModeNames.ADD:
		_Result = _Input + _OverWrite
	elif Mode == ModeNames.SUB:
		_Result = _Input - _OverWrite
	elif Mode == ModeNames.MULT:
		_Result == _Input * _OverWrite
	else:
		_Result == _Input / _OverWrite
	get_node("DataTable/DataTableHeader/Value").text = str(_Result)

func _Overwrite_Parameter(Changed_Param):
	_OverWrite = Changed_Param

func _Change_Input(Changed_Param):
	_Input = Changed_Param


func _on_ADD_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Mode = ModeNames.ADD
			get_node("DataTable/ModeDisplay").text = "ADD"

func _on_SUBTRACT_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Mode = ModeNames.SUB
			get_node("DataTable/ModeDisplay").text = "SUBTRACT"

func _on_MULTIPLY_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Mode = ModeNames.MULT
			get_node("DataTable/ModeDisplay").text = "MULTIPLY"

func _on_DIVIDE_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			Mode = ModeNames.ADD
			get_node("DataTable/ModeDisplay").text = "DIVIDE"
