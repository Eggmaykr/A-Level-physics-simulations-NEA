extends Control

var DataSelectionAxis : String = "X"

func _ready():
	print(open_data())

func open_data():
	var result = Database.run_custom_query("SELECT ColorID, ValueName, UnqBoardID FROM Experiments")
	return result
	

func select_data(data_id):
	pass

func trunctate_data(data):
	var ArrayOfPreviousExperimentIDs = []
	for datapiece in data:
		if ArrayOfPreviousExperimentIDs.find(datapiece["ColorID"]) == -1:
			ArrayOfPreviousExperimentIDs.append(datapiece["ColorID"])
	return ArrayOfPreviousExperimentIDs
