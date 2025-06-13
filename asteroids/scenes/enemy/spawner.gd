extends Node2D

@export var enemy_to_spawn : PackedScene

var offset = 50.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _on_create_enemy_timer_timeout():
	var new_enemy = enemy_to_spawn.instantiate()
	var rand_pos_x = randf_range(0 + offset, screen_size.x - offset )
	var rand_pos_y = randf_range(0 + offset, screen_size.y - offset )
	new_enemy.global_position = Vector2(rand_pos_x, rand_pos_y)
	get_tree().get_current_scene().add_child(new_enemy)
