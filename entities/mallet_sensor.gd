class_name MalletSensor
extends Area2D

signal sensor_activated

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("pulsing")
	
