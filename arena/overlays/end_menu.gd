class_name EndMenu
extends Control

var big_text: String = "GAME OVER"

signal rematch_selected
signal quit_selected

@onready var big_text_label: Label = $TextControl/BigText
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mallet_sensors = $MalletSensors
@onready var p1_rematch_sensor: MalletSensor = $MalletSensors/RematchSensorP1
@onready var p2_rematch_sensor: MalletSensor = $MalletSensors/RematchSensorP2
@onready var p1_quit_sensor: MalletSensor = $MalletSensors/QuitSensorP1
@onready var p2_quit_sensor: MalletSensor = $MalletSensors/QuitSensorP2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	big_text_label.text = big_text
	animation_player.play("celebrate")
	for child in mallet_sensors.get_children():
		if child is MalletSensor:
			child.sensor_changed.connect(_on_sensor_changed)
			

func _on_sensor_changed() -> void:
	if p1_rematch_sensor.activated and p2_rematch_sensor.activated:
		rematch_selected.emit()
		queue_free()
	elif p1_quit_sensor.activated and p2_quit_sensor.activated:
		quit_selected.emit()
		queue_free()
		# add a more graceful animation before queue freeing
		
	
