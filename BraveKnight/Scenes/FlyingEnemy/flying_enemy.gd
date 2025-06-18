extends BaseEnemy

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_ref: Player
@onready var timer: Timer = $PatrolTimer

var direction = Vector2.RIGHT

func _ready():
	movement_speed = 1000.0
	player_ref = get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta):
	nav_agent.target_position = player_ref.global_position

func _physics_process(delta):
	match current_state: 
		ENEMY_STATE.PATROL: 
			velocity.x = direction.x * movement_speed * delta
		ENEMY_STATE.FOLLOWING_PLAYER:
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = dir * movement_speed * delta
	move_and_slide()

func _on_patrol_timer_timeout():
	if direction == Vector2.RIGHT:
		direction = Vector2.LEFT
		anim_sprite.flip_h = true
	else:
		direction = Vector2.RIGHT
		anim_sprite.flip_h = false

func _on_detection_area_area_entered(area):
	print("Player detected!")
	super._set_state(ENEMY_STATE.FOLLOWING_PLAYER)
	movement_speed *= 1.5
	timer.stop()

func _on_detection_area_area_exited(area):
	print("Player escaped!")
	super._set_state(ENEMY_STATE.PATROL)
	velocity.y = 0 
	timer.start()
