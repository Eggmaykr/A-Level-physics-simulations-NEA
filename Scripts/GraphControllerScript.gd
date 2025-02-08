extends Control

var DataSelectionAxis : String = "X"
var DataSetSelectionScenePath : String = "res://ExperimentParts/DataSetSelectionPart.tscn"
var XAxisData : Array = []
var YAxisData : Array = []


func open_data():
	get_node("SelectData").show()
	var result = Database.run_custom_query("SELECT ColorID, ValueName, UnqBoardID FROM Experiments")
	result = trunctate_data(result)
	for DataLink in result:
		var DataSetSelectionPanelInstance = load(DataSetSelectionScenePath).instance()
		print(DataLink, "Data")
		DataSetSelectionPanelInstance.create(DataLink)
		get_node("SelectData/LoadScroll/LoadGrid").add_child(DataSetSelectionPanelInstance)
	

func select_data(data_id):
	print("SELECT ValueName, ValueValue FROM Experiments WHERE ColorID = " + "'" + data_id["ColorID"] + "'" +" and UnqBoardID = " + str(data_id["UnqBoardID"]))
	self.set(DataSelectionAxis + "AxisData", Database.run_custom_query("SELECT ValueName, ValueValue FROM Experiments WHERE ColorID = " + "'" + data_id["ColorID"] + "'" +" and UnqBoardID = " + str(data_id["UnqBoardID"])))
	print(get(DataSelectionAxis + "AxisData"))
	get_node("SelectData").hide()
	if XAxisData != [] and YAxisData != []:
		pass

func trunctate_data(data):
	var ArrayOfPreviousExperimentIDs = []
	var ReturnArray = []
	for datapiece in data:
		if ArrayOfPreviousExperimentIDs.find(datapiece["ColorID"]) == -1:
			ArrayOfPreviousExperimentIDs.append(datapiece["ColorID"])
			ReturnArray.append(datapiece)
	return ReturnArray


func _on_SelectDataX_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			DataSelectionAxis = "X"
			open_data()


func _on_SelectDataY_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			DataSelectionAxis = "Y"
			open_data()
	
