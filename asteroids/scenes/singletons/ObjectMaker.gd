extends Node

@export var player_bullet = preload("res://scenes/player/player_bullet.tscn")

func create_bullet(angle : float, speed : float, marker_pos : Vector2):
	print("Fire!")
	var new_bullet = player_bullet.instantiate()
	var direction = Vector2(cos(angle), sin(angle))
	new_bullet.setup_bullet(direction, speed)
	new_bullet.global_position = marker_pos
	new_bullet.global_rotation = angle
	get_tree().root.add_child(new_bullet)
