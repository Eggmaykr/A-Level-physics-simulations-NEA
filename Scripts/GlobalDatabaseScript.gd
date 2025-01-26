extends Node

var DataBasePath : String = ""
var SQLite := preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

func _ready():
	var database = SQLite.new()
	database.path = "res://BigData.db"
	database.open_db()
	pass

func write_to_database():
	pass

func remove_from_database():
	pass

func update_database():
	pass

func get_from_database():
	pass
