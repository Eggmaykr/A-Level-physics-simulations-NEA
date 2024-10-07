extends Control

var TimeElapsed : float = 0.0
var FrequencyOfLightHertz : float = 0.0
var WavelengthMetersXTenMillion : float = 100.0
var WorkFunctionJoules : float = 7.53 * pow(10, -19)
var PlanksConstantJoulesPerSecond : float = 6.62607015*pow(10.0,-32.0)
var KineticEnergyJoules : float = 0.0
var MassOfElectronKilogram : float = 9.1093837*pow(10.0,-31.0)
var SpeedOfLightMetersPerSecond : float = 299792458

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

func _create_electron():
	var ElectronInstance = load("res://ExperimentParts/Electron.tscn").instantiate()
	ElectronInstance.rotation_degrees = rand_range(-50,50)
	var randomisedEnergy = rand_range(WorkFunctionJoules, PlanksConstantJoulesPerSecond*FrequencyOfLightHertz)
	KineticEnergyJoules = randomisedEnergy - WorkFunctionJoules
	ElectronInstance.speed = sqrt((KineticEnergyJoules*2)/MassOfElectronKilogram)
	print(ElectronInstance.speed)
	
