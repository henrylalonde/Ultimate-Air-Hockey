class_name ScoreBoard
extends PanelContainer

@onready var p1_score_label: Label = $MarginContainer/HBoxContainer/HomePanel/HomeScore
@onready var p2_score_label: Label = $MarginContainer/HBoxContainer/ScorePanel/GuestScore

var on_screen_position := Vector2(756.0, 26.0)
var off_screen_position := Vector2(756.0, -128.0)

var sliding_tween: Tween

signal score_board_hidden
signal score_board_updated


func update_score(p1_score: int, p1_previous_score: int, p2_score: int, p2_previous_score: int) -> void:
	if p1_score != p1_previous_score:
		p1_score_label.text = ""
	if p2_score != p2_previous_score:
		p2_score_label.text = ""
	
	await get_tree().create_timer(0.2).timeout
	
	p1_score_label.text = str(p1_score)
	p2_score_label.text = str(p2_score)
	score_board_updated.emit()


# slide in, update score, slide out
func peek_score(p1_score: int, p1_previous_score: int, p2_score: int, p2_previous_score: int) -> void:
	p1_score_label.text = str(p1_previous_score)
	p2_score_label.text = str(p2_previous_score)
	
	await slide_down_board()
	
	await update_score(p1_score, p1_previous_score, p2_score, p2_previous_score)
	
	await get_tree().create_timer(1.5).timeout
	
	slide_up_board()


# slide in, update score, stay there
func show_score(p1_score: int, p1_previous_score: int, p2_score: int, p2_previous_score: int) -> void:
	p1_score_label.text = str(p1_previous_score)
	p2_score_label.text = str(p2_previous_score)
	
	await slide_down_board()
	
	await update_score(p1_score, p1_previous_score, p2_score, p2_previous_score)


func slide_down_board() -> void:
	if sliding_tween:
		sliding_tween.kill()
	show()
	sliding_tween = create_tween()
	sliding_tween.set_trans(Tween.TRANS_SINE)
	sliding_tween.set_ease(Tween.EASE_OUT)
	sliding_tween.tween_property(self, "position", on_screen_position, 0.5)
	await sliding_tween.finished
	

func slide_up_board() -> void:
	sliding_tween = create_tween()
	sliding_tween.set_trans(Tween.TRANS_SINE)
	sliding_tween.set_ease(Tween.EASE_IN)
	sliding_tween.tween_property(self, "position", off_screen_position, 0.5)
	await sliding_tween.finished
	hide()
	score_board_hidden.emit()
