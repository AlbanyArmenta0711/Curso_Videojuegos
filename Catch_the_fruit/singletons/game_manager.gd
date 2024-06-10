extends Node

@export var score: int = 0 
@export var lives: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_fruit_caught.connect(on_fruit_caught)
	SignalManager.on_bomb_caught.connect(on_bomb_caught)

func on_fruit_caught(score: int):
	print("Has atrapado una fruta! +" + str(score))
	
func on_bomb_caught():
	print("Has atrapado una bomba! :c")
