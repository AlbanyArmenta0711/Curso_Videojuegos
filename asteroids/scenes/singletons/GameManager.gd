extends Node

var score = 0 
var game_scene = preload("res://scenes/main_level/main_level.tscn")
var game_over = false 

func _ready():
	game_over = false

func load_game_scene(): 
	#get_tree().change_scene_to_packed(game_scene)
	print(get_tree().reload_current_scene())

func increment_score(): 
	score += 1
	SignalManager.on_score_update.emit(score)
