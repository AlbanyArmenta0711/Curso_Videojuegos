extends CharacterBody2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var anim_player = $AnimationPlayer
@onready var audio_player = $SoundPlayer

enum PLAYER_STATE {IDLE, RUN, JUMP, FALL, HURT}

var _current_state : PLAYER_STATE = PLAYER_STATE.IDLE

const GRAVITY : float = 500.0
const RUN_SPEED : float = 120.0 
const MAX_FALL : float = 400.0
const JUMP_VELOCITY: float = -350.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	get_input()
	calculate_state()
	move_and_slide()

func get_input():
	velocity.x = 0 
	if Input.is_action_pressed("move_left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true 
	elif Input.is_action_pressed("move_right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false 
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundsManager.play_sound(audio_player, SoundsManager.SOUND_JUMP)
		
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)

func calculate_state():
	if is_on_floor():
		if velocity.x == 0:
			set_state(PLAYER_STATE.IDLE)
		else:
			set_state(PLAYER_STATE.RUN)
	else: 
		if velocity.y > 0:
			set_state(PLAYER_STATE.FALL)
		else: 
			set_state(PLAYER_STATE.JUMP)
	
func set_state(new_state : PLAYER_STATE):
	if new_state != _current_state:
		
		if _current_state == PLAYER_STATE.FALL and new_state == PLAYER_STATE.RUN or new_state == PLAYER_STATE.IDLE:
			SoundsManager.play_sound(audio_player, SoundsManager.SOUND_LAND)
		
		_current_state = new_state
		
		match _current_state:
			PLAYER_STATE.IDLE:
				anim_player.play("idle")
			PLAYER_STATE.RUN:
				anim_player.play("run")
			PLAYER_STATE.FALL:
				anim_player.play("fall")
			PLAYER_STATE.JUMP:
				anim_player.play("jump")
	else:
		return
