class_name Mallet
extends RigidBody2D

var desired_position: Vector2

var slow_down: float = 1.0
var max_slow_down: float = 0.9
var velocity_threshold: float = 800.0
var speed_integral: float = 0.0
var integral_threshold: float = 0.5
var max_integral: float = 1000.0

@export var damping: float = 1.0
@export var proportional: float = 1.0

@onready var stamina_bar: TextureProgressBar = $StaminaBar

func _ready() -> void:
	desired_position = global_position


func _physics_process(delta: float) -> void:
	speed_integral += (linear_velocity.length() - velocity_threshold) * delta
	speed_integral = clampf(speed_integral, 0.0, max_integral)
	slow_down = 1.0 - max_slow_down * clampf(2.0*speed_integral/max_integral - integral_threshold, 0.0, 1.0)
	stamina_bar.value = speed_integral / max_integral
	
	var pos_error: Vector2 = desired_position - global_position
	var damping_force: Vector2 = -damping * linear_velocity
	var proportional_force: Vector2 = slow_down * proportional * pos_error
	apply_central_force(damping_force + proportional_force)
