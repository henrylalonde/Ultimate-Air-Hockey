extends Node

var player1_score: int = 0
var player2_score: int = 0

var middle_field := Vector2(960.0, 540.0)
var left_field := Vector2(540.0, 540.0)
var right_field := Vector2(1380.0, 540.0)

@onready var puck_scene: PackedScene = load("res://entities/puck.tscn")
@onready var puck: RigidBody2D = $Puck
@onready var score_board: ScoreBoard = $ScoreBoard


func _ready() -> void:
	score_board.start_display_timer(5.7)

func reset_puck(reset_position: Vector2) -> void:
	puck.queue_free()
	puck = puck_scene.instantiate()
	puck.global_position = reset_position
	get_parent().add_child(puck)


func print_score() -> void:
	print(str(player1_score) + " | " + str(player2_score))


func _on_left_goal_body_entered(body: Node2D) -> void:
	if body == puck:
		print("Player 2 Scored!")
		player2_score += 1
		print_score()
		call_deferred("reset_puck", left_field)
		

func _on_right_goal_body_entered(body: Node2D) -> void:
	if body == puck:
		print("Player 1 Scored!")
		player1_score += 1
		print_score()
		call_deferred("reset_puck", right_field)
