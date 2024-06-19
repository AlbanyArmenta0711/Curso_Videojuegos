extends Control

@onready var hearts_container = $MarginContainer/HBoxContainer/HeartsContainer
@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel

const DEFAULT_SCORE_TEXT = "Score: "

var hearts_array : Array

func _ready():
	hearts_array = hearts_container.get_children()
	SignalManager.on_lives_changed.connect(on_lives_changed)
	SignalManager.on_score_changed.connect(on_score_changed)
	
func on_lives_changed(lives : int):
	for idx in range(hearts_array.size()):
		hearts_array[idx].visible = idx < lives 

func on_score_changed(score : int):
	score_label.text = DEFAULT_SCORE_TEXT + str(score)
	
	
