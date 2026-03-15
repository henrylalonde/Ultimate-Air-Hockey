extends PanelContainer

var master_bus_idx: int = 0
var music_bus_idx: int = 1
var sfx_bus_idx: int = 2

@onready var fullscreen_button: Button = $MarginContainer/VBoxContainer/FullScreenButton
@onready var volume_sliders: Array[HSlider] = [
	$MarginContainer/VBoxContainer/VolumeOptions/MasterVolumeSlider,
	$MarginContainer/VBoxContainer/VolumeOptions/MusicVolumeSlider,
	$MarginContainer/VBoxContainer/VolumeOptions/SFXVolumeSlider
]


signal back_button_pressed

func _ready() -> void:
	for i in range(len(volume_sliders)):
		var slider: HSlider = volume_sliders[i]
		slider.value = AudioServer.get_bus_volume_linear(i)
		slider.value_changed.connect(_on_volume_slider_value_changed.bind(i))
		
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_button.button_pressed = true
	else:
		fullscreen_button.button_pressed = false


func _on_volume_slider_value_changed(value: float, index: int) -> void:
	AudioServer.set_bus_volume_linear(index, value)


func _on_full_screen_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		ProjectSettings.set_setting("display/window/size/mode", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		ProjectSettings.set_setting("display/window/size/mode", DisplayServer.WINDOW_MODE_WINDOWED)



func _on_back_button_pressed() -> void:
	ResourceSaver.save(AudioServer.generate_bus_layout(), "default_bus_layout.tres")
	ProjectSettings.save()
	back_button_pressed.emit()
