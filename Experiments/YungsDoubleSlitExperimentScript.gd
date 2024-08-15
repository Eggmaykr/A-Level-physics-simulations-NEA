extends Control

var Wavelength : float = 0.001
var SlitSpacingMeters : float = 0.001
var RadiusOfWaves1 : Array = []
var MaxRadius : float = 100.0
const Subdivisions : int = 1000


func _ready():
	pass

func _physics_process(delta):
	for WaveSetNum in range(RadiusOfWaves1.size()):
		RadiusOfWaves1[WaveSetNum] += 10*delta
		var XValuesIncrease : float = RadiusOfWaves1[WaveSetNum]/(Subdivisions/2)
		for sub in range(Subdivisions/2):
			var NegativePoint = (sub + 1 )*-1
			var X = sub*XValuesIncrease+261
			var YPos : float = (1454.0 + sqrt((1454.0 * 1454.0) - (4*(528529.0+(X-261)*(X-261) - RadiusOfWaves1[WaveSetNum]*RadiusOfWaves1[WaveSetNum]))))/2
			var YNeg : float = (1454.0 - sqrt((1454.0 * 1454.0) - (4*(528529.0+(X-261)*(X-261) - RadiusOfWaves1[WaveSetNum]*RadiusOfWaves1[WaveSetNum]))))/2
			get_node("WaveSets").get_child(WaveSetNum).ChangePointWave1(sub, Vector2(X-261, YPos-753))
			get_node("WaveSets").get_child(WaveSetNum).ChangePointWave1(NegativePoint, Vector2(X-261, YNeg-753))
			var YPosW2 : float = (1656.0 + sqrt((1656.0 * 1656.0) - (4*(685584.0 + (X-261)*(X-261) - RadiusOfWaves1[WaveSetNum]*RadiusOfWaves1[WaveSetNum]))))/2
			var YNegW2 : float = (1656.0 - sqrt((1656.0 * 1656.0) - (4*(685584.0 + (X-261)*(X-261) - RadiusOfWaves1[WaveSetNum]*RadiusOfWaves1[WaveSetNum]))))/2
			get_node("WaveSets").get_child(WaveSetNum).ChangePointWave2(sub, Vector2(X-261, YPosW2-854))
			get_node("WaveSets").get_child(WaveSetNum).ChangePointWave2(NegativePoint, Vector2(X-261, YNegW2-854))

func _createRipple():
	pass

func createWaves():
	var XValuesIncrease : float = 1.5/(Subdivisions/2)
	var Wave = load("res://ExperimentParts/WaveSet.tscn")
	var WaveInstance = Wave.instance()
	get_node("WaveSets").add_child(WaveInstance)
	print(get_node("WaveSets").get_child_count())
	for sub in range(Subdivisions):
		get_node("WaveSets").get_child(get_node("WaveSets").get_child_count()-1).SetUP(Vector2(261, 727))
	RadiusOfWaves1.append(1.5)


func _on_Slits_area_entered(area):
	if area.is_in_group("RIpple"):
		area.get_parent().queue_free()
		createWaves()
