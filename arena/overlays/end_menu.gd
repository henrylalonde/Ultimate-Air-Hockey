class_name EndMenu
extends Control

var big_text: String = "GAME OVER"

@onready var big_text_label: Label = $TextControl/BigText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	big_text_label.text = big_text
	animation_player.play("celebrate")
