class_name ScoreBoard
extends PanelContainer

@onready var time_label: Label = $HBoxContainer/TimePanel/TimeLabel
@onready var timer: Timer = $SecondTimer

var display_time: int = 0

func set_time_label(time: int) -> void:
	@warning_ignore("integer_division")
	var minutes: int = time / 60
	var seconds: int = time % 60
	if seconds < 10:
		time_label.text = str(minutes) + ":0" + str(seconds)
	else:
		time_label.text = str(minutes) + ":" + str(seconds)
	


func start_display_timer(time: float) -> void:
	display_time = floor(time)
	set_time_label(display_time)
	timer.start(time - display_time)



func stop_display_timer() -> void:
	timer.stop()


func _on_second_timer_timeout() -> void:
	if timer.wait_time != 1.0:
		timer.start(1.0)
	display_time -= 1
	if display_time >= 0:
		set_time_label(display_time)
	
