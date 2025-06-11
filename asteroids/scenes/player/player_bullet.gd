extends Area2D

var current_direction = Vector2.RIGHT

func _ready():
	pass

#Bullet direction will be relative to player direction
func setup_bullet(player_direction : Vector2, bullet_speed : float):
	print(player_direction)
	current_direction = player_direction.normalized() * bullet_speed

func _process(delta):
	position += current_direction * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Bullet being eliminated")
	queue_free()
