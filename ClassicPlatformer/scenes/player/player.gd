extends CharacterBody2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var anim_player = $AnimationPlayer
@onready var audio_player = $SoundPlayer
@onready var invincible_timer = $InvincibleTimer
@onready var jump_collision = $JumpHitBox/CollisionShape2D

enum PLAYER_STATE {IDLE, RUN, JUMP, FALL, HURT}

var _current_state : PLAYER_STATE = PLAYER_STATE.IDLE
var is_invincible: bool = false 

const GRAVITY : float = 800.0
const RUN_SPEED : float = 120.0 
const MAX_FALL : float = 400.0
const JUMP_VELOCITY: float = -450.0
const HURT_JUMP_VELOCITY : float = -300.0

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_collision.disabled = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	get_input()
	calculate_state()
	move_and_slide()

func get_input():
	velocity.x = 0 
	if _current_state != PLAYER_STATE.HURT:
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
	if is_invincible:
		set_state(PLAYER_STATE.HURT)
	else: 
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
			jump_collision.disabled = true 
		_current_state = new_state
		match _current_state:
			PLAYER_STATE.IDLE:
				anim_player.play("idle")
			PLAYER_STATE.RUN:
				anim_player.play("run")
			PLAYER_STATE.FALL:
				anim_player.play("fall")
				jump_collision.disabled = false 
			PLAYER_STATE.JUMP:
				anim_player.play("jump")
			PLAYER_STATE.HURT:
				SoundsManager.play_sound(audio_player, SoundsManager.SOUND_HURT)
				anim_player.play("hurt")
	else:
		return
		
func _on_hit_box_area_entered(area):
	if not is_invincible:
		apply_hit()
		SignalManager.on_hurt.emit()

func apply_hit():
	is_invincible = true 
	var tween = get_tree().create_tween()
	tween.set_loops(1)
	tween.tween_property(sprite_2d,"self_modulate",Color(1,0,0,0.5),0.5)
	tween.tween_property(sprite_2d,"self_modulate",Color(1,1,1,1),0.5)
	velocity.y = HURT_JUMP_VELOCITY
	invincible_timer.start()

func _on_invincible_timer_timeout():
	is_invincible = false
	print("Fin de invincibilidad")

func _on_jump_hit_box_area_entered(area):
	print("Jump hit box collision")
	velocity.y = HURT_JUMP_VELOCITY
