extends Control

var DataTablePartPath = "res://ExperimentParts/DataTablePart.tscn"
var Data : Array = []

func Update():
	if get_parent().get_parent().get_node("Sockets/MainConnector").WireConnected != null:
		Data = get_parent().get_parent().get_node("Sockets/MainConnector")._activate_Sender(false)
		for Datanum in range(get_node("DataTable").get_child_count()-1):
			get_node("DataTable").get_child(Datanum+1).queue_free()
		for Data_Piece in Data:
			var DataTablePart = load(DataTablePartPath).instance()
			get_node("DataTable").add_child(DataTablePart)
			get_node("DataTable").get_child(-1).get_node("DataType").text = Data_Piece[0]
			get_node("DataTable").get_child(-1).get_node("DataValue").text = str(Data_Piece[1])

func _Pause(_Blank):
	Update()
