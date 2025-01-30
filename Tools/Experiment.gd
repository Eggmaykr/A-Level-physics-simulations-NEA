extends Control

var DataStored
var ExperimentName

func _ready():
	Database.write_to_database()

func _on_Update_pressed():
	pass # Replace with function body.


func _on_Delete_pressed():
	Database.remove_from_database()
