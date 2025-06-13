extends Area2D

class_name EnemyBullet

var direction : Vector2 = Vector2.UP
var bullet_speed : float = 1.0

func setup_enemy_bullet(start_direction : Vector2):
	direction = start_direction.normalized() * bullet_speed
	
func _process(delta):
	position += direction
