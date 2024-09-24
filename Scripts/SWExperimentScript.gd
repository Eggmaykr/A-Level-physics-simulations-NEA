extends Control

var LengthOfWireMeters = 0.35
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
	createWire(100.0)
	
func _process(delta):
	TimeSeconds += delta
	for pointNumber in range(subdivisions):
		var tempCurrentX = get_node("StandingWave").points[pointNumber].x
		get_node("StandingWave").points[pointNumber].y = 2*Amplitude*cos(((2*PI)/Wavelength)*tempCurrentX/10)*cos(2*PI*FrequencyHertz*TimeSeconds)

func createWire(subdivs):
	subdivisions = subdivs
	var tempSizeForSubdivs : float = maxSize/subdivs
	print(tempSizeForSubdivs)
	for pointNumber in range(subdivs):
		var tempCurrentX : float = (maxSize/subdivs) * pointNumber * LengthOfWireMeters
		print(tempCurrentX)
		var tempAmplitudeAtPoint = 2*Amplitude*cos(((2*PI)/Wavelength)*tempCurrentX/10)*cos(2*PI*FrequencyHertz*TimeSeconds)
		get_node("StandingWave").add_point(Vector2(tempCurrentX, tempAmplitudeAtPoint))


func _on_Wavelength_value_changed(value):
	WaveSpeedMS = value
	Wavelength = WaveSpeedMS/FrequencyHertz

func _on_Frequency_value_changed(value):
	FrequencyHertz = value/10
	Wavelength = WaveSpeedMS/FrequencyHertz


func _on_Pause_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			_Pause()

func _Pause(_Black = false):
	if is_processing() == false:
		get_parent().get_parent().get_node("Selected/Pause").pressed = true
		set_process(true)
	elif is_processing() == true:
		get_parent().get_parent().get_node("Selected/Pause").pressed = false
		set_process(false)

func _Read_Variables(_Black):
	return [["Wavelength", Wavelength],["Frequency", FrequencyHertz]]

