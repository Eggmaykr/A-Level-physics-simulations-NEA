extends Node2D

var Load = false

func _ready():
	if Load == true:
		var LoadItems = Database.run_custom_query("SELECT ItemFilePath, ItemName, ItemID FROM WhiteboardItems WHERE UnqBoardID = " + str(Database.CurrentWhiteBoardID))
		for Item in LoadItems:
			var ItemInstance = load(Item["ItemFilePath"]).instance()
			ItemInstance.name = Item["ItemName"]
			ItemInstance.initialise(Item["ItemID"])
			get_node("Items").add_child(ItemInstance)
		var LoadConnections = Database.run_custom_query("SELECT ItemNameFrom, ItemNameTo, ConnectingSocketFrom, ConnectingSocketTo FROM Connections WHERE UnqBoardID = " + str(Database.CurrentWhiteBoardID))
		for connection in LoadConnections:
			var SocketConnectionFrom = get_node("Items").get_node(connection["ItemNameFrom"]).get_node("Sockets").get_node(connection["ConnectingSocketFrom"])
			var SocketConnectionTo = get_node("Items").get_node(connection["ItemNameTo"]).get_node("Sockets").get_node(connection["ConnectingSocketTo"])
			get_node(connection["ItemNameFrom"]).get_node("Sockets").get_node(connection["ConnectingSocketFrom"])._Create_Quick_Connection(SocketConnectionFrom,SocketConnectionTo									)
