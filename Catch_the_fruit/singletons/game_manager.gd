extends Node

var _score: int = 0 
var _lives: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_fruit_caught.connect(on_fruit_caught)
	SignalManager.on_spikes_caught.connect(on_spikes_caught)

func on_fruit_caught(score: int):
	_score += score
	print("Has atrapado una fruta! +" + str(_score))
	
func on_spikes_caught():
	_lives -= 1 
	print("Te has picado! :c x" + str(_lives))
