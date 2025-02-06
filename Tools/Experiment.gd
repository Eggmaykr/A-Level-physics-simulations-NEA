extends Control

var DataStored = []
var ExperimentID : int = 0
var ExperimentColorCode : Color

func _ready():
	print(get_parent().get_parent().name)

func _Update(Blank = false):
	print(DataStored, str(ExperimentColorCode), " RES:", ExperimentID)
	Database.write_to_database("Experiments", {
		"UnqBoardID": Database.CurrentWhiteBoardID,
		"ValueName" : DataStored[0],
		"ValueValue" : DataStored[1],
		"ColorID" : str(ExperimentColorCode)
		})

func _on_Update_pressed():
	_Update()

func ChangeValue(data):
	DataStored = data
	get_node("DataView/ValueName").text = "Value Type: " + data[0]
	get_node("DataView/ValueValue").text = "Value Value: " + str(data[1])


func _on_ColorPicker_color_changed(color):
	ExperimentColorCode = color
	get_node("ColorID").modulate = color
