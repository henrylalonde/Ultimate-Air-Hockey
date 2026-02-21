extends Node

@onready var player1: Mallet = get_parent().get_node("Player1")
@onready var player2: Mallet = get_parent().get_node("Player2")

var left_start := Vector2(215.0, 540.0)
var right_start := Vector2(1705.0, 540.0)

var min_corner := Vector2(0.0, 0.0)
var max_corner := Vector2(1920.0, 1080.0)

var raw_mouse: RawMouse

func _ready() -> void:
	raw_mouse = RawMouse.new()
	raw_mouse.set_p1_position(left_start)
	raw_mouse.set_p2_position(right_start)
	raw_mouse.set_p1_bound(min_corner.x, min_corner.y, max_corner.x / 2, max_corner.y)
	raw_mouse.set_p2_bound(max_corner.x / 2, min_corner.y, max_corner.x, max_corner.y)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	player1.desired_position = raw_mouse.get_p1_position()
	player2.desired_position = raw_mouse.get_p2_position()
	
