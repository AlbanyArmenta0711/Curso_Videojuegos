extends Node

var _score : int = 0 
var _lives : int = 3

func _ready():
	SignalManager.on_hurt.connect(on_hurt)
	SignalManager.on_score_grabbed.connect(on_score_grabbed)
	
func on_hurt():
	_lives -= 1
	SignalManager.on_lives_changed.emit(_lives)
	print("Vidas: " + str(_lives))

func on_score_grabbed(score: int ):
	_score += score
	SignalManager.on_score_changed.emit(_score)
