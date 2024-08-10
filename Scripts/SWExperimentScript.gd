extends Control

var LengthOfWireMeters = 1
var Wavelength : float = 0
var FrequencyHertz : float = 0.5
var FundamentalFrequency = 0
var MassPerUnitLengthKilograms = 10
var WaveSpeedMS : float = 10
var WhichHarmonic = 0
var MassOfWeightKilograms = 10
var TentionN = 0
var Gravity : float = -9.81
var TimeSeconds = 0
const Amplitude = 10

var subdivisions : float = 50
var maxSize : float = 1300
func _ready():
	Wavelength = WaveSpeedMS/FrequencyHertz
	TentionN = MassOfWeightKilograms * Gravity
	createWire(500.0)
	
func _physics_process(delta):
	TimeSeconds += delta
	for pointNumber in range(subdivisions):
		var tempCurrentX = get_node("StandingWave").points[pointNumber].x
		get_node("StandingWave").points[pointNumber].y = 2*Amplitude*cos(((2*PI)/Wavelength)*tempCurrentX/10)*cos(2*PI*FrequencyHertz*TimeSeconds)

func createWire(subdivs):
	subdivisions = subdivs
	var tempSizeForSubdivs : float = maxSize/subdivs
	print(tempSizeForSubdivs)
	for pointNumber in range(subdivs):
		var tempCurrentX : float = (maxSize/subdivs) * pointNumber
		print(tempCurrentX)
		var tempAmplitudeAtPoint = 2*Amplitude*cos(((2*PI)/Wavelength)*tempCurrentX/10)*cos(2*PI*FrequencyHertz*TimeSeconds)
		get_node("StandingWave").add_point(Vector2(tempCurrentX, tempAmplitudeAtPoint))
