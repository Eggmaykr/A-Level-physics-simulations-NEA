extends Panel

var SelfData : Dictionary = {}

func _ready():
	self.set("custom_styles/panel", StyleBoxFlat.new())
	var ColorArray = self.SelfData["ColorID"].split(",")
	self.get("custom_styles/panel").bg_color = Color(float(ColorArray[0]), float(ColorArray[1]), float(ColorArray[2]), float(ColorArray[3]))
	self.get_node("ValueName").text = self.SelfData["ValueName"]
	self.get_node("WhiteboardID").text = "[adv]Whiteboard ID" + str(self.SelfData["UnqBoardID"])

func _on_DataSetSelection_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			get_parent().get_parent().get_parent().get_parent().select_data(self.SelfData)

func create(ContainData):
	self.SelfData = ContainData
