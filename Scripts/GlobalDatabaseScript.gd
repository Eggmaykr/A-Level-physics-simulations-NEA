extends Node

var DataBasePath : String = ""
var SQLite := preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var database = null

func _ready():
	database = SQLite.new()
	database.path = "res://BigData.db"
	database.open_db()
	var BoardTable = {
		"UnqBoardID" : {"data_type":"int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"BoardName" : {"data_type" : "text"},
		"DateCreated" : {"data_type" : "text"},
		"NumberOfBoardElements" : {"data_type" : "int"}
	}
	database.create_table("Whiteboards", BoardTable)

func write_to_database(table_name, data):
	database.insert_row(table_name, data)

func remove_from_database():
	pass

func update_database():
	pass

func get_from_database():
	pass
