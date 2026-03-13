class_name PauseMenu
extends Control

signal game_unpaused
signal game_paused
signal reset_game
signal quit_game

@onready var pause_buttons := $PauseButtons
@onready var options_menu := $OptionsMenu


func unpause_game() -> void:
	hide()
	get_tree().paused = false
	game_unpaused.emit()


func pause_game() -> void:
	get_tree().paused = true
	game_paused.emit()
	show()


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			pause_game()
		elif options_menu.is_visible_in_tree():
			_on_options_menu_back_button_pressed()
		else:
			unpause_game()


func _on_reset_button_pressed() -> void:
	unpause_game()
	reset_game.emit()


func _on_options_button_pressed() -> void:
	pause_buttons.hide()
	options_menu.show()


func _on_options_menu_back_button_pressed() -> void:
	options_menu.hide()
	pause_buttons.show()


func _on_quit_button_pressed() -> void:
	unpause_game()
	quit_game.emit()
