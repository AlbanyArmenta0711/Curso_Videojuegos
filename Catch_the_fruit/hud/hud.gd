extends Control

@onready var lives_label = $MainContainer/HorizontalContainer/LivesLabel
@onready var score_label = $MainContainer/HorizontalContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_lives_change.connect(on_lives_change)
	SignalManager.on_score_change.connect(on_score_change)


func on_lives_change(lives: int):
	lives_label.text = "Lives:" + str(lives)
	
func on_score_change(score: int): 
	score_label.text = str(score)
