extends Node

var DataBasePath : String = ""
var SQLite := preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var database = null
var CurrentWhiteBoardID : int = 0

func _ready():
	database = SQLite.new()
	database.path = "res://BigData.db"
	database.foreign_keys = true
	database.open_db()
	var BoardTable = {
		"UnqBoardID" : {"data_type":"int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"BoardName" : {"data_type" : "text"},
		"DateCreated" : {"data_type" : "text"},
		"NumberOfBoardElements" : {"data_type" : "int"}
	}
	database.create_table("Whiteboards", BoardTable)
	var ItemsTable = {
		"ItemID" : {"data_type" : "text", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"UnqBoardID" : {"data_type":"int", "foreign_key" : true, "not_null" : true},
		"ItemName" : {"data_type":"text"},
		"ItemFilePath" : {"data_type":"text"},
		"ItemSettings" : {"data_type" : "blob"},
	}
	database.create_table("WhiteboardItems", ItemsTable)
	var ExperimentData = {
		"UnqBoardID": {"data_type" : "int", "foreign_key" : true, "not_null" : true},
		"ValueName" : {"data_type" : "text"},
		"ValueValue" : {"data_type" : "real"},
		"ColorID" : {"data_type" : "text"}
	}
	database.create_table("Experiments", ExperimentData)
	var ConnectionData = {
		"ItemIDFrom" : {"data_type":"int", "foreign_key" : true, "not_null" : true},
		"ItemIDTo" : {"data_type":"int", "foreign_key" : true, "not_null" : true},
		"ConnectingSocketFrom" : {"data_type" : "int"},
		"ConnectingSocketTo" : {"data_type" : "int"}
	}
	database.create_table("Connections", ConnectionData)

func write_to_database(table_name, updatedData : Dictionary):
	database.insert_row(table_name, updatedData)

func remove_from_database(table_name : String, primaryKeyName : String, primaryKey : int):
	database.delete_rows(table_name, primaryKeyName + " = " + str(primaryKey))

func update_database(table_name : String, primaryKeyName : String, primaryKey : int, updatedData : Dictionary):
	print(database.update_rows(table_name, primaryKeyName + " = " + str(primaryKey), updatedData), "Result")

func run_custom_query(query_string : String):
	database.query(query_string)
	return database.query_result

func get_size_of_table(table_name, table_unique_key_name : String):
	database.query("SELECT " + table_unique_key_name + " FROM " + table_name)
	print("Result:", database.query_result)
	return database.query_result.size()
