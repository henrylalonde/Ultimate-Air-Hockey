extends Node

@onready var player1: Mallet = $Player1
@onready var player2: Mallet = $Player2

var left_start := Vector2(215.0, 540.0)
var right_start := Vector2(1705.0, 540.0)

var min_corner := Vector2(0.0, 0.0)
var max_corner := Vector2(1920.0, 1080.0)

var raw_mouse: RawMouse


func _on_game_paused() -> void:
	raw_mouse.freeze_input()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_game_unpaused() -> void:
	raw_mouse.unfreeze_input()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _ready() -> void:
	raw_mouse = RawMouse.new()
	raw_mouse.set_p1_position(left_start)
	raw_mouse.set_p2_position(right_start)
	raw_mouse.set_p1_bound(min_corner.x, min_corner.y, max_corner.x / 2, max_corner.y)
	raw_mouse.set_p2_bound(max_corner.x / 2, min_corner.y, max_corner.x, max_corner.y)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(_delta: float) -> void:
	player1.desired_position = raw_mouse.get_p1_position()
	player2.desired_position = raw_mouse.get_p2_position()
	
