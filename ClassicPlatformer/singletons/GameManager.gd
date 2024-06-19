extends Node

var score : int = 0 
var lives : int = 3

func _ready():
	SignalManager.on_hurt.connect(on_hurt)
	
func on_hurt():
	lives -= 1
	SignalManager.on_lives_changed.emit(lives)
	print("Vidas: " + str(lives))
