extends Node

var main_menu_scene : PackedScene = preload("res://main_menu/main_menu.tscn")
var game_scene : PackedScene = preload("res://level_base/level_base.tscn")

var _global_score : int = 0
var _lives: int = 1

func _ready():
	SignalManager.on_fruit_caught.connect(on_fruit_caught)
	SignalManager.on_spikes_caught.connect(on_spike_caught)

func load_main_menu_scene():
	get_tree().change_scene_to_packed(main_menu_scene)

func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)

func on_fruit_caught(score: int): 
	_global_score += score
	SignalManager.on_score_changed.emit(_global_score)
	
func on_spike_caught():
	_lives -= 1
	SignalManager.on_lives_changed.emit(_lives)
	if _lives == 0:
		SignalManager.on_game_over.emit()
