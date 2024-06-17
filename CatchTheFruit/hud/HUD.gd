extends Control

@onready var lives_label = $MarginContainer/HBoxContainer/LivesLabel
@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel

const lives_default_text = "Vidas: "
const score_default_text = "Puntaje: "

func _ready():
	lives_label.text = lives_default_text + "1"
	score_label.text = score_default_text + "0"
	SignalManager.on_lives_changed.connect(on_lives_changed)
	SignalManager.on_score_changed.connect(on_score_changed)
	
func on_lives_changed(lives: int):
	lives_label.text = lives_default_text + str(lives)

func on_score_changed(score: int):
	score_label.text = score_default_text + str(score)
