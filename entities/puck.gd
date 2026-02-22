extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
var normal_sprite_scale := Vector2(0.25, 0.25)
var large_sprite_scale := Vector2(0.3, 0.3)



func _ready() -> void:
	var tween := create_tween()
	sprite.scale = large_sprite_scale
	tween.tween_property(sprite, "scale", normal_sprite_scale, 0.15)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
