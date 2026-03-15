extends Node

var config_file: ConfigFile
var config_file_path: String = "user://options.cfg"
var bus_layout_path: String = "user://user_bus_layout.tres"


func _ready() -> void:
	config_file = ConfigFile.new()
	
	var error = config_file.load(config_file_path)
	
	if error != OK:
		return
	
	var window_mode: DisplayServer.WindowMode = config_file.get_value("Options", "window_mode", DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_mode(window_mode)
	
	var bus_layout: AudioBusLayout = ResourceLoader.load(bus_layout_path)
	AudioServer.set_bus_layout(bus_layout)


func save() -> void:
	config_file.set_value("Options", "window_mode", DisplayServer.window_get_mode())
	
	var bus_layout: AudioBusLayout = AudioServer.generate_bus_layout()
	ResourceSaver.save(bus_layout, bus_layout_path)
	
	config_file.save(config_file_path)
