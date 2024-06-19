extends Control

@onready var hearts_container = $MarginContainer/HBoxContainer/HeartsContainer

var hearts_array : Array

func _ready():
	hearts_array = hearts_container.get_children()
	SignalManager.on_lives_changed.connect(on_lives_changed)
	
func on_lives_changed(lives : int):
	for idx in range(hearts_array.size()):
		hearts_array[idx].visible = idx < lives 
