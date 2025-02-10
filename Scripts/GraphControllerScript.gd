extends Control

var DataSelectionAxis : String = "X"
var DataSetSelectionScenePath : String = "res://ExperimentParts/DataSetSelectionPart.tscn"
var XAxisData : Array = []
var YAxisData : Array = []


func open_data():
	for child in get_node("SelectData/LoadScroll/LoadGrid").get_children():
		child.queue_free()
	get_node("SelectData").show()
	var result = Database.run_custom_query("SELECT ColorID, ValueName, UnqBoardID FROM Experiments")
	result = trunctate_data(result)
	for DataLink in result:
		var DataSetSelectionPanelInstance = load(DataSetSelectionScenePath).instance()
		print(DataLink, "Data")
		DataSetSelectionPanelInstance.create(DataLink)
		get_node("SelectData/LoadScroll/LoadGrid").add_child(DataSetSelectionPanelInstance)
	

func select_data(data_id):
	self.set(DataSelectionAxis + "AxisData", Database.run_custom_query("SELECT ValueValue FROM Experiments WHERE ColorID = " + "'" + data_id["ColorID"] + "'" +" and UnqBoardID = " + str(data_id["UnqBoardID"]) + " ORDER BY ValueValue ASC"))
	print(get(DataSelectionAxis + "AxisData"))
	get_node(DataSelectionAxis+ "AxisName").text = data_id["ValueName"]
	get_node("SelectData").hide()
	if XAxisData != [] and YAxisData != []:
		create_line()

func create_line():
	if XAxisData.size() <= YAxisData.size():
		for linepoint in get_node("Line").points:
			get_node("Line").remove_point(0)
		var graphSpreadDifferenceX = 1100/XAxisData[-1]["ValueValue"]
		var graphSpreadDifferenceY = 1800/YAxisData[-1]["ValueValue"]
		for data_pieceX in XAxisData:
			get_node("Line").add_point(Vector2(data_pieceX["ValueValue"]*graphSpreadDifferenceX, 0.0))
		for pointIndex in range(XAxisData.size()):
			get_node("Line").points[pointIndex].y = -YAxisData[pointIndex]["ValueValue"]*graphSpreadDifferenceY
	else:
		for linepoint in get_node("Line").points:
			get_node("Line").remove_point(0)
		var graphSpreadDifferenceX = 1100/XAxisData[-1]["ValueValue"]
		var graphSpreadDifferenceY = 1800/YAxisData[-1]["ValueValue"]
		for data_pieceY in YAxisData:
			print(data_pieceY["ValueValue"])
			get_node("Line").add_point(Vector2(0.0, -data_pieceY["ValueValue"]*graphSpreadDifferenceY))
		for pointIndex in range(YAxisData.size()):
			print(XAxisData[pointIndex]["ValueValue"]*graphSpreadDifferenceX, " ", XAxisData[pointIndex]["ValueValue"])
			get_node("Line").points[pointIndex].x = XAxisData[pointIndex]["ValueValue"]*graphSpreadDifferenceX

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
	
