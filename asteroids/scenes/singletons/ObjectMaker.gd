extends Node


@export var player_bullet = preload("res://scenes/player/player_bullet.tscn")
@export var enemy_bullet = preload("res://scenes/enemy/EnemyBullet.tscn")

func create_bullet(angle : float, speed : float, marker_pos : Vector2):
	var new_bullet = player_bullet.instantiate()
	var direction = Vector2(cos(angle), sin(angle))
	new_bullet.setup_bullet(direction, speed)
	new_bullet.global_position = marker_pos
	new_bullet.rotation = direction.angle()
	get_tree().get_current_scene().add_child(new_bullet)

func create_enemy_bullet(angle : float, marker_pos : Vector2): 
	var new_bullet = enemy_bullet.instantiate()
	var direction = Vector2(cos(angle), sin(angle))
	new_bullet.setup_enemy_bullet(direction)
	new_bullet.global_position = marker_pos
	new_bullet.rotation = direction.angle()
	get_tree().get_current_scene().add_child(new_bullet)
	
