extends Node

var p1_score: int = 0
var p2_score: int = 0

var middle_field := Vector2(960.0, 540.0)
var left_field := Vector2(540.0, 540.0)
var right_field := Vector2(1380.0, 540.0)

@onready var puck_scene: PackedScene = load("res://entities/puck.tscn")
@onready var puck: RigidBody2D
@onready var score_board: ScoreBoard = $ScoreBoard
@onready var game_objects: Node2D = $GameObjects
@onready var menu: GameMenu = $Menu


func set_puck(reset_position: Vector2) -> void:
	puck = puck_scene.instantiate()
	puck.global_position = reset_position
	game_objects.add_child(puck)


func _ready() -> void:
	score_board.peek_score(0, 0, 0, 0)
	await score_board.score_board_hidden
	set_puck(middle_field)


func _on_left_goal_body_entered(body: Node2D) -> void:
	if body != puck:
		return
	puck.queue_free()
	p2_score += 1
	if p2_score >= 7:
		score_board.show_score(p1_score, p1_score, p2_score, p2_score - 1)
		await score_board.score_board_updated
		menu.show_win_message("P2 Wins!")
	else:
		score_board.peek_score(p1_score, p1_score, p2_score, p2_score - 1)
		await score_board.score_board_hidden
		call_deferred("set_puck", left_field)
		

func _on_right_goal_body_entered(body: Node2D) -> void:
	if body != puck:
		return
	puck.queue_free()
	p1_score += 1
	if p1_score >= 7:
		score_board.show_score(p1_score, p1_score - 1, p2_score, p2_score)
		await score_board.score_board_updated
		menu.show_win_message("P1 Wins!")
	else:
		score_board.peek_score(p1_score, p1_score - 1, p2_score, p2_score)
		await score_board.score_board_hidden
		call_deferred("set_puck", right_field)

# error when puck is freed by goal process and reset process, double free
func _on_menu_reset_game() -> void:
	p1_score = 0
	p2_score = 0
	puck.queue_free()
	score_board.peek_score(0, 0, 0, 0)
	await score_board.score_board_hidden
	set_puck(middle_field)
	
