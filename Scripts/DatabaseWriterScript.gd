extends Control

var DataStored = []
var ExperimentColorCode : Color

func _ready():
	var ownName = get_parent().get_parent().name

func _Update(Blank = false):
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

func get_defaults():
	var ReturnData : String = var2str({"ExperimentColorCode": ExperimentColorCode})
	return ReturnData

func load_settings(settings):
	var settingsArray = str2var(settings["ItemSettings"])
	ExperimentColorCode = settingsArray["ExperimentColorCode"]
	get_node("ColorID").modulate = ExperimentColorCode

func update_settings():
	Database.update_database("Experiments", "ItemID", get_parent().get_parent().UniqSelfID, {"ItemSettings" : var2str({"ExperimentColorCode": ExperimentColorCode})})
