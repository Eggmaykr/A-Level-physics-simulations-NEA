extends Control

var DataSelectionAxis : String = "X"

func open_data():
	var result = Database.run_custom_query("SELECT ExperimentID, ColorID, ValueName FROM Experiments")
	

func select_data(data_id):
	pass

func trunctate_data(data):
	var ArrayOfPreviousExperimentIDs = []
	for datapiece in data:
		pass
	return ArrayOfPreviousExperimentIDs
