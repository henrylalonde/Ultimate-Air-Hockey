extends Node

@onready var player1: Mallet = get_parent().get_node("Player1")
@onready var player2: Mallet = get_parent().get_node("Player2")

var raw_mouse: RawMouse

func _ready() -> void:
	raw_mouse = RawMouse.new()
	raw_mouse.set_p1_position(Vector2(551.0, 540.0))
	raw_mouse.set_p2_position(Vector2(1384.0, 540.0))
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	player1.desired_position = raw_mouse.get_p1_position()
	player2.desired_position = raw_mouse.get_p2_position()
	
