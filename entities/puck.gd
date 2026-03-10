extends RigidBody2D

@onready var light_mallet_hit_sound: AudioStreamWAV = preload("res://assets/wav/light_mallet_hit.wav")
@onready var light_wall_hit_sound: AudioStreamWAV = preload("res://assets/wav/light_wall_hit.wav")

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var normal_sprite_scale := Vector2(0.25, 0.25)
var large_sprite_scale := Vector2(0.3, 0.3)

var collision_sound_threshold: float = 50.0


func _ready() -> void:
	var tween := create_tween()
	sprite.scale = large_sprite_scale
	tween.tween_property(sprite, "scale", normal_sprite_scale, 0.15)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.get_contact_count() > 0:
		for i in range(state.get_contact_count()):
			var contact_normal = state.get_contact_local_normal(i)
			var collider = state.get_contact_collider_object(i)
			
			if collider:
				handle_collision(collider, contact_normal, state.linear_velocity)

func handle_collision(body: Node, normal: Vector2, current_velocity: Vector2) -> void:
	if body.is_in_group("wall"):
		var impulse: float = abs(current_velocity.dot(normal))
		if impulse < collision_sound_threshold:
			return
		var volume_level: float = 5 * log(impulse + 0.001) - 30.0
		audio_stream_player.get_stream_playback().play_stream(light_wall_hit_sound, 0, volume_level)
		
	elif body.is_in_group("mallet"):
		var mallet_vel = body.linear_velocity
		var impulse: float = abs((current_velocity - mallet_vel).dot(normal))
		if impulse < collision_sound_threshold:
			return
		var volume_level: float = 4.5 * log(impulse + 0.001) - 30.0
		audio_stream_player.get_stream_playback().play_stream(light_mallet_hit_sound, 0, volume_level)
