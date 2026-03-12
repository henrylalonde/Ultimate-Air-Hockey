class_name MalletSensor
extends Area2D

signal sensor_changed

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: TextureProgressBar = $ProgressBar

@export var wait_time: float = 1.0
var current_progress: float = 0.0
var activated: bool = false

func _ready() -> void:
	animation_player.play("pulsing")
	

func _physics_process(delta: float) -> void:
	if get_overlapping_bodies().is_empty():
		current_progress = clampf(current_progress - delta, 0.0, wait_time)
		if activated:
			activated = false
			sensor_changed.emit()
	else:
		current_progress = clampf(current_progress + delta, 0.0, wait_time)
		if current_progress == wait_time and not activated:
			activated = true
			sensor_changed.emit()
	progress_bar.value = current_progress / wait_time
