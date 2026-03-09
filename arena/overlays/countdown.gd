class_name Countdown
extends Control

signal countdown_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("countdown_animation")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	countdown_finished.emit()
	queue_free()


func reset() -> void:
	animation_player.stop()
	animation_player.play("countdown_animation")
