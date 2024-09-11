extends Control

export var SecondsPassed : float = 0
export var Gravity : float = -9.81
export var MassKg : float = 0.01
export var Spring_Constant : float = 10.0
export var ForceNewtons : float = 0.0
export var ExtentionM : float = 0.0
export var MaximumAmplitude : float = 0.5
export var Displacement : float = 0
export var OriginalLengthM : float = 1.0
export var Period : float = 0
export var Frequency : float = 0
export var AngularSpeed : float = 0

var Multiplier : float = 0

func _ready():
	Period = 2*PI*sqrt(MassKg/Spring_Constant)
	Frequency = 1/Period
	print(Period, MassKg)
	AngularSpeed = 2*PI*Frequency
	Multiplier = 1/OriginalLengthM

func _process(delta):
	print(delta)
	SecondsPassed += delta
	print(cos(AngularSpeed*SecondsPassed))
	Displacement = MaximumAmplitude*cos(AngularSpeed*SecondsPassed)
	get_node("Spring").rect_scale.y = 1 + Displacement*Multiplier
	get_node("Weight").rect_global_position = get_node("Spring/WeightPosition").rect_global_position
	print(get_node("Spring").rect_scale.y, " ", Period)


func _on_SpringConstantSlider_value_changed(value):
	get_parent().get_parent().get_node("Expandable/EditableValues/SpringConstantSlider/ParameterValue").text = str(value)
	Spring_Constant = value
	Period = 2*PI*sqrt(MassKg/Spring_Constant)
	Frequency = 1/Period
	AngularSpeed = 2*PI*Frequency
	Multiplier = 1/OriginalLengthM

func _on_MassSlider_value_changed(value):
	get_parent().get_parent().get_node("Expandable/EditableValues/MassSlider/ParameterValue").text = str(value)
	get_node("Weight/Label").text = str(value) + "kg"
	# 1:20
	MassKg = value
	Period = 2*PI*sqrt(MassKg/Spring_Constant)
	Frequency = 1/Period
	AngularSpeed = 2*PI*Frequency
	Multiplier = 1/OriginalLengthM
