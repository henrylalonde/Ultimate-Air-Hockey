extends Node2D

@onready var mallet_sensor: MalletSensor = $MalletSensor
@onready var mallet: Mallet = $Mallet

func _ready() -> void:
	RawMouseAutoload.set_p1_position(mallet.position)
	mallet_sensor.sensor_changed.connect(_on_sensor_changed)

func _physics_process(delta: float) -> void:
	mallet.desired_position = RawMouseAutoload.get_p1_position()
	

func _on_sensor_changed() -> void:
	print("sensor changed")
	
