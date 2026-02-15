class_name Mallet
extends RigidBody2D

var desired_position: Vector2

@export var damping: float = 1.0
@export var proportional: float = 1.0


func _ready() -> void:
	desired_position = global_position


func _physics_process(_delta: float) -> void:
	var pos_error: Vector2 = desired_position - global_position
	var damping_force: Vector2 = -damping * linear_velocity
	var proportional_force: Vector2 = proportional * pos_error
	apply_central_force(damping_force + proportional_force)
