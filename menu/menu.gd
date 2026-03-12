extends Node

@onready var arena_scene: PackedScene = load("res://arena/arena.tscn")


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(arena_scene)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
