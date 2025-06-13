extends CanvasLayer

@onready var score_label_ref = $MarginContainer/ScoreLabel

func _ready():
	SignalManager.on_score_update.connect(update_score_label)
	
func update_score_label(score: int): 
	score_label_ref.text = "Score: " + str(score) 
