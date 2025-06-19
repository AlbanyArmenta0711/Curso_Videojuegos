extends CharacterBody2D

class_name BaseEnemy

enum ENEMY_STATE {PATROL, FOLLOWING_PLAYER, HURT, DEATH, RETURNING}



var current_state: ENEMY_STATE = ENEMY_STATE.PATROL
var hp = 2
var movement_speed = 1500.0

func _set_state(new_state : ENEMY_STATE):
	if(current_state != new_state):
		current_state = new_state

	
