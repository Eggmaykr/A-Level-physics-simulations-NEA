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
		"UnqBoardID" : {"data_type":"int", "foreign_key" : true, "not_null" : true},
		"ItemFilePath" : {"data_type":"text"},
		"ItemSettings" : {"data_type" : "blob"},
		"ItemID" : {"data_type" : "int"},
		"ConnectedItemIDs" : {"data_type" : "blob"}
	}

func write_to_database(table_name, updatedData : Dictionary):
	database.insert_row(table_name, updatedData)

func remove_from_database(table_name : String, primaryKeyName : String, primaryKey : int):
	database.delete_rows(table_name, primaryKeyName + " = " + str(primaryKey))

func update_database(table_name : String, primaryKeyName : String, primaryKey : int, updatedData : Dictionary):
	database.update_rows(table_name, primaryKeyName + " = " + str(primaryKey), updatedData)

func select_from_database(query_string : String):
	database.query(query_string)
	return database.query_result

func get_size_of_table(table_name, table_unique_key_name):
	database.query("SELECT " + table_unique_key_name, " FROM " + table_name)
	return database.query_result.size()
