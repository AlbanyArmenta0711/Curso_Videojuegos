extends Node

var score = 0 
var game_scene = preload("res://scenes/main_level/main_level.tscn")
var menu_scene = preload("res://scenes/main_menu/MainMenu.tscn")

func on_game_start(): 
	get_tree().change_scene_to_packed(game_scene)

func on_return_to_menu():
	get_tree().change_scene_to_packed(menu_scene)

func on_exit():
	get_tree().quit()

func increment_score(): 
	score += 1
	SignalManager.on_score_update.emit(score)
