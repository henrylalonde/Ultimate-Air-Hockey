class_name Mallet
extends RigidBody2D

# state variables
var desired_position: Vector2
var slow_down: float = 1.0
var speed_integral: float

# adjustable parameters
var max_slow_down: float = 0.9			# percentage of proportional force lost at minimum stamina
var velocity_threshold: float = 2500.0	# puck speed must be above threshold for stamina to decrease
var positive_gain: float = 1/500.0		# proportional to rate of stamina decrease (velocity - threshold > 0)
var negative_gain: float = 1/4000.0		# proportional to rate of stamina decrease (velocity - threshold < 0)
var integral_threshold: float = 0.5 	# integral must be above threshold for speed decrease to occur

@export var damping: float = 50.0
@export var proportional: float = 1000.0

@onready var stamina_bar: TextureProgressBar = $StaminaBar



func _ready() -> void:
	desired_position = global_position



func _physics_process(delta: float) -> void:
	var threshold_dif = linear_velocity.length() - velocity_threshold
	if threshold_dif > 0:
		speed_integral += positive_gain * threshold_dif * delta
	else:
		speed_integral += negative_gain * threshold_dif * delta
	speed_integral = clampf(speed_integral, 0.0, 1.0)
	slow_down = 1.0 - max_slow_down * clampf(speed_integral - integral_threshold, 0.0, 1.0) / (1.0 - integral_threshold)
	stamina_bar.value = speed_integral
	
	var pos_error: Vector2 = desired_position - global_position
	var damping_force: Vector2 = -damping * linear_velocity
	var proportional_force: Vector2 = slow_down * proportional * pos_error
	apply_central_force(damping_force + proportional_force)
