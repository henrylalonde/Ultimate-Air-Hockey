extends Node

@onready var player1: Mallet = get_parent().get_node("Player1")
@onready var player2: Mallet = get_parent().get_node("Player2")


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	player1.desired_position = mouse_position
	player2.desired_position = Vector2(1500.0, 540.0)
	
# Desired functionality
# player1.desired_position = RawInput.get_pointer_pos(0)
# player2.desired_position = RawInput.get_pointer_pos(1)
