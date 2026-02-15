extends Node

@onready var player1: Mallet = get_parent().get_node("Player1")

func _physics_process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	player1.desired_position = mouse_position
