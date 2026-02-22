class_name GameMenu
extends PanelContainer

signal game_unpaused
signal game_paused
signal reset_game

@onready var fullscreen_button: Button = $MarginContainer/VBoxContainer/FullscreenToggle
@onready var label: Label = $MarginContainer/VBoxContainer/Label


func show_win_message(message: String) -> void:
	pause_game()
	label.text = message


func unpause_game() -> void:
	hide()
	get_tree().paused = false
	game_unpaused.emit()


func pause_game() -> void:
	label.text = "Paused"
	get_tree().paused = true
	game_paused.emit()
	show()


func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_button.button_pressed = true
	else:
		fullscreen_button.button_pressed = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			unpause_game()
		else:
			pause_game()


func _on_reset_button_pressed() -> void:
	unpause_game()
	reset_game.emit()


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
