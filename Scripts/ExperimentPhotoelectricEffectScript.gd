extends Control

var TimeElapsed : float = 0.0
var FrequencyHertz : float = 0.0
var WavelengthMetersXTenMillion : float = 100.0
var WorkFunctionJoules : float = 10.0
var PlanksConstantJoulesPerSecond : float = 6.62607015*pow(10.0,-32.0)
var KineticEnergy : float = 0.0
var MassOfElectron : float = 9.1093837*pow(10.0,-31.0)

func _ready():
	for i in range(100):
		#y = sin(deg_to_rad(i))
		var Point = Vector2(i*1.4, sin(i*0.4)*20.0)
		get_node("LightWave").add_point(Point)
	

func _process(delta):
	TimeElapsed += delta+0.2
	for i in range(100):
		get_node("LightWave").points[i].y = sin((i+TimeElapsed)/WavelengthMetersXTenMillion*1000.0)*20.0


func _on_Wavelength_value_changed(value):
	WavelengthMetersXTenMillion = value
	get_node("LightWave").default_color = Color.from_hsv((0.720-(1.0/8000.0)*WavelengthMetersXTenMillion),1.0, 0.82,1.0)
