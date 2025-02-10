extends Control

var _Input : Array = ["Nothing", 0.0]
var _OverWrite : Array = ["Nothing", 0.0]
var _Result : Array = ["Nothing", 0.0]

enum ModeNames {ADD, SUB, MULT, DIV = 0}
var Mode : int = ModeNames.ADD

func _ready():
	get_parent().get_parent().Open = true

func _Update(_Parameter = false):
	if Mode == ModeNames.ADD:
		_Result[1] = _Input[1] + _OverWrite[1]
	elif Mode == ModeNames.SUB:
		_Result[1] = _Input[1] - _OverWrite[1]
	elif Mode == ModeNames.MULT:
		_Result[1] = _Input[1] * _OverWrite[1]
	else:
		_Result[1] = _Input[1] / _OverWrite[1]
	_Result[0] = _Input[0]
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

func get_defaults():
	var ReturnData : String = str(to_json({"Mode": Mode}))
	return ReturnData

func load_settings(settings):
	var settingsArray = str2var(settings["ItemSettings"])
	Mode = settingsArray["Mode"]
	if Mode == ModeNames.ADD:
		get_node("DataTable/ModeDisplay").text = "ADD"
	elif Mode == ModeNames.SUB:
		get_node("DataTable/ModeDisplay").text = "SUBTRACT"
	elif Mode == ModeNames.MULT:
		get_node("DataTable/ModeDisplay").text = "MULTIPLY"
	elif Mode == ModeNames.DIV:
		get_node("DataTable/ModeDisplay").text = "DIVIDE"

func update_settings():
	Database.update_database("Experiments", "ItemID", get_parent().get_parent().UniqSelfID, {"ItemSettings" : var2str({"Mode": Mode})})
