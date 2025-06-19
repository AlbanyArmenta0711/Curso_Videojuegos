extends BaseEnemy

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_ref: Player
@onready var timer: Timer = $PatrolTimer
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var previous_state: ENEMY_STATE 
var direction = Vector2.RIGHT
var initial_pos: Vector2
var is_hurt: bool = false

func _ready():
	movement_speed = 1000.0
	player_ref = get_tree().get_nodes_in_group("Player")[0]
	initial_pos = global_position
	
func _process(delta):
	nav_agent.target_position = player_ref.global_position

func _physics_process(delta):
	if not is_hurt:
		match current_state: 
			ENEMY_STATE.RETURNING: 
				nav_agent.target_position = initial_pos
				direction = to_local(nav_agent.get_next_path_position()).normalized()
			ENEMY_STATE.PATROL: 
				if timer.is_stopped():
					timer.start()
			ENEMY_STATE.FOLLOWING_PLAYER:
				if not timer.is_stopped():
					timer.stop()
				nav_agent.target_position = player_ref.global_position
				direction = to_local(nav_agent.get_next_path_position()).normalized()
		
	velocity = direction * movement_speed * delta
	move_and_slide()

func _on_patrol_timer_timeout():
	if current_state != ENEMY_STATE.DEATH:
		if direction == Vector2.RIGHT:
			direction = Vector2.LEFT
			anim_sprite.flip_h = true
		else:
			direction = Vector2.RIGHT
			anim_sprite.flip_h = false

func _on_detection_area_area_entered(area):
	if current_state != ENEMY_STATE.DEATH:
		print("Player detected!")
		super._set_state(ENEMY_STATE.FOLLOWING_PLAYER)
		timer.stop()
		anim_sprite.play("Idle")

func _on_detection_area_area_exited(area):
	if current_state != ENEMY_STATE.DEATH:
		print("Player escaped!")
		super._set_state(ENEMY_STATE.RETURNING)
		velocity.y = 0 
		anim_sprite.play("Idle")
		timer.start()

func _on_navigation_finished() -> void:
	if current_state == ENEMY_STATE.RETURNING:
		current_state = ENEMY_STATE.PATROL

func _on_hit_box_area_entered(area: Area2D) -> void:
	is_hurt = true 
	hp -= player_ref.strength
	if hp <= 0: 
		current_state = ENEMY_STATE.DEATH
		anim_sprite.play("Death")
		var tween = create_tween()
		print(tween)
		tween.tween_property(anim_sprite,"scale",Vector2.ONE * 0.25, 0.25)
		direction = Vector2.ZERO
		
	else: 
		direction *= -direction
		movement_speed *= 3
		previous_state = current_state
		current_state = ENEMY_STATE.HURT
		invincible_timer.start()
		var tween = create_tween()
		print(tween)
		tween.tween_property(anim_sprite,"self_modulate",Color(1, 0.5, 0), 0.25)
		tween.tween_property(anim_sprite,"self_modulate",Color.WHITE, 0.25)
		tween.tween_property(anim_sprite,"self_modulate",Color(1, 0.5, 0), 0.25)
		tween.tween_property(anim_sprite,"self_modulate",Color.WHITE, 0.25)
		
func _on_invincible_timer_timeout() -> void:
	is_hurt = false
	print("invincible end")
	current_state = previous_state
	movement_speed /= 3
	
func _on_animation_finished() -> void:
	if anim_sprite.animation == "Death":
		print("Enemy Destroyed")
		queue_free()
