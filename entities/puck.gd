extends RigidBody2D

@onready var light_mallet_hit_sound: AudioStreamWAV = load("res://assets/wav/light_mallet_hit.wav")
@onready var light_wall_hit_sound: AudioStreamWAV = load("res://assets/wav/light_wall_hit.wav")

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var normal_sprite_scale := Vector2(0.25, 0.25)
var large_sprite_scale := Vector2(0.3, 0.3)



func _ready() -> void:
	var tween := create_tween()
	sprite.scale = large_sprite_scale
	tween.tween_property(sprite, "scale", normal_sprite_scale, 0.15)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)


func _on_body_entered(body: Node) -> void:
	print(linear_velocity)
	if body.is_in_group("wall"):
		var volume_level: float = 4.2 * log(linear_velocity.length_squared() + 0.001) - 48.0
		audio_stream_player.get_stream_playback().play_stream(light_wall_hit_sound, 0, volume_level)
	elif body.is_in_group("mallet"):
		var volume_level: float = 5 * log((linear_velocity - body.linear_velocity).length() + 0.001) - 30.0
		audio_stream_player.get_stream_playback().play_stream(light_mallet_hit_sound, 0, volume_level)
	
