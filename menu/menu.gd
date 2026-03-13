extends Node

@onready var arena_scene: PackedScene = load("res://arena/arena.tscn")

@onready var p1_mouse_indicator: TextureRect = $UI/MouseCheck/MarginContainer/VBoxContainer/P1MouseCheck/TextureRect
@onready var p2_mouse_indicator: TextureRect = $UI/MouseCheck/MarginContainer/VBoxContainer/P2MouseCheck/TextureRect
@onready var main_menu: VBoxContainer = $UI/MainMenu
@onready var options_menu: PanelContainer = $UI/OptionsMenu

var connected_color: Color = Color("37db37ff")
var disconnected_color: Color = Color("dc3838ff")


func update_indicators() -> void:
	if RawMouseAutoload.is_p1_connected():
		p1_mouse_indicator.modulate = connected_color
	else:
		p1_mouse_indicator.modulate = disconnected_color
	
	if RawMouseAutoload.is_p2_connected():
		p2_mouse_indicator.modulate = connected_color
	else:
		p2_mouse_indicator.modulate = disconnected_color


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	update_indicators()
	RawMouseAutoload.new_mouse_connected.connect(update_indicators)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(arena_scene)


func _on_options_button_pressed() -> void:
	main_menu.hide()
	options_menu.show()


func _on_options_menu_back_button_pressed() -> void:
	options_menu.hide()
	main_menu.show()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
