extends Node

var p1_score: int = 0
var p2_score: int = 0

var middle_field := Vector2(960.0, 540.0)
var left_field := Vector2(540.0, 540.0)
var right_field := Vector2(1380.0, 540.0)

var process_token: int = 0

@onready var puck_scene: PackedScene = preload("res://entities/puck.tscn")
@onready var countdown_scene: PackedScene = preload("res://arena/overlays/countdown.tscn")
@onready var end_menu_scene: PackedScene = preload("res://arena/overlays/end_menu.tscn")

@onready var puck: RigidBody2D
@onready var countdown: Countdown
@onready var end_menu: EndMenu

@onready var score_board: ScoreBoard = $ScoreBoard
@onready var game_objects: Node2D = $GameObjects
@onready var pause_menu: PauseMenu = $PauseMenu


func set_puck(reset_position: Vector2) -> void:
	puck = puck_scene.instantiate()
	puck.global_position = reset_position
	game_objects.add_child(puck)


func _ready() -> void:
	start_game()


func start_game() -> void:
	p1_score = 0
	p2_score = 0
	process_token += 1
	var local_token = process_token
	score_board.peek_score(0, 0, 0, 0)
	if is_instance_valid(countdown):
		countdown.reset()
	else:
		countdown = countdown_scene.instantiate()
		add_child(countdown)
	await countdown.countdown_finished
	if process_token == local_token:
		set_puck(middle_field)


func _on_left_goal_body_entered(body: Node2D) -> void:
	if body != puck:
		return
	puck.queue_free()
	p2_score += 1
	if p2_score >= 7:
		score_board.show_score(p1_score, p1_score, p2_score, p2_score - 1)
		await score_board.score_board_updated
		display_end_menu("P2 Wins!")
	else:
		process_token += 1
		var local_token = process_token
		score_board.peek_score(p1_score, p1_score, p2_score, p2_score - 1)
		await score_board.score_board_hidden
		if process_token == local_token:
			call_deferred("set_puck", left_field)


func _on_right_goal_body_entered(body: Node2D) -> void:
	if body != puck:
		return
	puck.queue_free()
	p1_score += 1
	if p1_score >= 7:
		score_board.show_score(p1_score, p1_score - 1, p2_score, p2_score)
		await score_board.score_board_updated
		display_end_menu("P1 Wins!")
	else:
		process_token += 1
		var local_token = process_token
		score_board.peek_score(p1_score, p1_score - 1, p2_score, p2_score)
		await score_board.score_board_hidden
		if process_token == local_token:
			call_deferred("set_puck", right_field)


func _on_menu_reset_game() -> void:
	if is_instance_valid(puck):
		puck.queue_free()
	start_game()


func display_end_menu(big_text: String) -> void:
	if is_instance_valid(end_menu):
		pass
	else:
		end_menu = end_menu_scene.instantiate()
		end_menu.big_text = big_text
		end_menu.rematch_selected.connect(start_game)
		end_menu.quit_selected.connect(get_tree().quit)
		pause_menu.reset_game.connect(end_menu.queue_free)
		add_child(end_menu)
	
