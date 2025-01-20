extends Control

var DataTablePartPath = "res://ExperimentParts/DataTablePart.tscn"
var Data : Array = []


func _Pause(_Blank):
	_Update(_Blank)

func _Update(_Blank = false):
	if get_parent().get_parent().get_node("Sockets/MainConnector").WireConnected != null:
		Data = get_parent().get_parent().get_node("Sockets/MainConnector")._activate_Sender(false)
		var DataSize = Data.size()
		if DataSize < get_node("DataTable").get_child_count()-1:
			for Datanum in range(get_node("DataTable").get_child_count()-1-DataSize):
				get_node("DataTable").get_child(Datanum+1+DataSize).queue_free()
				get_parent().get_parent().get_node("Sockets").get_child(Datanum+2+DataSize).queue_free()
		elif DataSize > get_node("DataTable").get_child_count()-1:
			var PreviousDataAmount = get_node("DataTable").get_child_count()-1
			for Data_Piece in range(DataSize-PreviousDataAmount):
				var DataTablePart = load(DataTablePartPath).instance()
				var ConnectorPart = load("res://MainGUI/WireConnection.tscn").instance()
				get_node("DataTable").add_child(DataTablePart)
				ConnectorPart.rect_global_position = Vector2(462, 68+PreviousDataAmount*64+Data_Piece*64)
				get_parent().get_parent().get_node("Sockets").add_child(ConnectorPart)
		for Data_Piece in range(DataSize):
			get_node("DataTable").get_child(Data_Piece+1).get_node("DataType").text = Data[Data_Piece][0]
			get_node("DataTable").get_child(Data_Piece+1).get_node("DataValue").text = str(Data[Data_Piece][1])

func _on_TouchScreenButton_pressed():
	self.queue_free()
