extends CharacterBody2D

@export var walk_speed = 3000.0
@export var gravity = 1500.0
@export var jump_speed = 1000.0

@onready var anim_sprite = $AnimatedSprite2D

enum PLAYER_STATES { IDLE, RUN, HURT, DEATH, ATTACK, JUMP, FALL }

var current_state : PLAYER_STATES = PLAYER_STATES.IDLE

func _ready():
	pass
	
func _physics_process(delta):
	apply_gravity(delta)
	get_input(delta)
	calculate_state()
	move_and_slide()
	
func get_input(delta):
	if (Input.is_action_pressed("move_left")):
		anim_sprite.flip_h = true
		velocity.x = -walk_speed * delta
	elif (Input.is_action_pressed("move_right")):
		anim_sprite.flip_h = false
		velocity.x = walk_speed * delta
	else:
		velocity.x = 0
		anim_sprite.play("idle")
		
	if(Input.is_action_just_pressed("jump")):
		velocity.y = -jump_speed
	
func calculate_state():
	if velocity.x == 0:
		set_state(PLAYER_STATES.IDLE)
	else:
		set_state(PLAYER_STATES.RUN)
	if velocity.y >= 0:
		set_state(PLA)
		
func set_state(new_state : PLAYER_STATES):
	if new_state != current_state: 
		current_state = new_state
		match current_state:
			PLAYER_STATES.IDLE:
				anim_sprite.play("idle")
			PLAYER_STATES.RUN: 
				anim_sprite.play("run")
	
	

func apply_gravity(delta):
	velocity.y += gravity * delta
		
