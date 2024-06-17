extends Control

var is_game_over = false 

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func _process(delta): 
	if Input.is_action_just_pressed("confirm") and is_game_over:
		GameManager.load_main_menu_scene()

func on_game_over():
	show()
	is_game_over = true
