extends CharacterBody2D

class_name Player

@export var walk_speed = 3000.0
@export var gravity = 1500.0
@export var jump_speed = 1000.0
@export var strength = 1.0

@onready var anim_sprite = $AnimatedSprite2D
@onready var floor_detector = $FloorDetector
@onready var sword_hitbox = $SwordHitBox
@onready var sword_hitbox_collision = $SwordHitBox/CollisionShape2D
@onready var invincible_timer = $InvincibleTimer

enum PLAYER_STATES { IDLE, RUN, HURT, DEATH, ATTACK, JUMP, FALL }

var current_state : PLAYER_STATES = PLAYER_STATES.IDLE
var is_on_ground = false 
var is_attacking = false
var is_hurt = false

var hit_direction: Vector2
var hit_force: float = 1.5

var direction_changed = false

func _ready():
	pass
	
func _physics_process(delta):
	apply_gravity(delta)
	check_is_on_ground()
	get_input(delta)
	calculate_state()
	move_and_slide()
	
func get_input(delta):
	if not is_hurt:
		if (Input.is_action_pressed("move_left")):
			if anim_sprite.flip_h == false: 
				anim_sprite.flip_h = true
				sword_hitbox_collision.position.x = sword_hitbox_collision.position.x * -1
			velocity.x = -walk_speed * delta
		elif (Input.is_action_pressed("move_right")):
			if anim_sprite.flip_h == true:
				anim_sprite.flip_h = false
				sword_hitbox_collision.position.x = sword_hitbox_collision.position.x * -1
			velocity.x = walk_speed * delta
		
		else:
			velocity.x = 0
			
		if (Input.is_action_just_pressed("jump") and is_on_ground):
			velocity.y = -jump_speed
			
		if (Input.is_action_just_pressed("attack") and not is_attacking):
			is_attacking = true
			set_state(PLAYER_STATES.ATTACK)
	else:
		velocity = hit_direction * walk_speed * delta * hit_force
		
	
func calculate_state():
	if not is_attacking and not is_hurt:
		if is_on_ground:
			if velocity.x == 0:
				set_state(PLAYER_STATES.IDLE)
			else:
				set_state(PLAYER_STATES.RUN)
		else:
			if velocity.y >= 0:
				set_state(PLAYER_STATES.FALL)
			else:
				set_state(PLAYER_STATES.JUMP)
		
func set_state(new_state : PLAYER_STATES):
	if new_state != current_state: 
		current_state = new_state
		match current_state:
			PLAYER_STATES.IDLE:
				anim_sprite.play("idle")
			PLAYER_STATES.RUN: 
				anim_sprite.play("run")
			PLAYER_STATES.FALL:
				anim_sprite.play("fall")
			PLAYER_STATES.JUMP:
				anim_sprite.play("jump")
			PLAYER_STATES.ATTACK:
				sword_hitbox.visible = true
				sword_hitbox.monitorable = true 
				sword_hitbox.monitoring = true
				anim_sprite.play("attack")
			PLAYER_STATES.HURT:
				anim_sprite.play("hurt")
	
func check_is_on_ground():
	if(floor_detector.is_colliding()):
		is_on_ground = true 
	else:
		is_on_ground = false 
	
func apply_gravity(delta):
	velocity.y += gravity * delta
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		print("Attack ended")
		is_attacking = false
		sword_hitbox.visible = false
		sword_hitbox.monitorable = false 
		sword_hitbox.monitoring = false
		set_state(PLAYER_STATES.IDLE)

func _on_hit_box_area_entered(area: Area2D) -> void:
	set_state(PLAYER_STATES.HURT)
	is_hurt = true
	invincible_timer.start()
	hit_direction = ((area.global_position - global_position) * -1).normalized()
	var tween = create_tween()
	tween.tween_property(anim_sprite,"self_modulate",Color(1, 0.5, 0), 0.25)
	tween.tween_property(anim_sprite,"self_modulate",Color.WHITE, 0.25)
	tween.tween_property(anim_sprite,"self_modulate",Color(1, 0.5, 0), 0.25)
	tween.tween_property(anim_sprite,"self_modulate",Color.WHITE, 0.25)
	
func _on_invincible_timer_timeout() -> void:
	set_state(PLAYER_STATES.IDLE)
	is_hurt = false
	is_attacking = false
