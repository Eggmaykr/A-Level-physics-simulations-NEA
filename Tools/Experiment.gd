extends Control

var DataStored = []
var ExperimentID : int = 0
var ExperimentColorCode : Color
var ManuallyInstantiated = true


func _ready():
	if ManuallyInstantiated == true:
		Database.write_to_database("Experiments", {
		"UnqBoardID" : Database.CurrentWhiteBoardID, 
		"ValueName" : "Nothing",
		"ValueValue" : 0.0,
		"ColorID" : str(Color.white)
		})
		ExperimentID = Database.get_size_of_table("Experiments", "ExperimentID")
	else:
		pass

func _on_Update_pressed():
	print(DataStored, str(ExperimentColorCode), " RES:", ExperimentID)
	Database.update_database("Experiments", "ExperimentID", ExperimentID, {
		"ValueName" : DataStored[0],
		"ValueValue" : DataStored[1],
		"ColorID" : str(ExperimentColorCode)
		})

func ChangeValue(data):
	DataStored = data
	get_node("DataView/ValueName").text = "Value Type: " + data[0]
	get_node("DataView/ValueValue").text = "Value Value: " + str(data[1])

func _on_Delete_pressed():
	Database.remove_from_database("Experiments", "ExperimentID", ExperimentID)


func _on_ColorPicker_color_changed(color):
	ExperimentColorCode = color
	get_node("ColorID").modulate = color
