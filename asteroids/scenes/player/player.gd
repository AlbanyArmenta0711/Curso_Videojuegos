extends CharacterBody2D

class_name Player

@onready var shoot_marker = $BulletMark

@export var MOVEMENT_SPEED = 150.0
@export var ROTATION_SPEED = 100.0

var screen_size
var can_shoot : bool = true 

#Called when the node enters the scene tree
func _ready():
	screen_size = get_viewport_rect().size

#Called every game frame
func _process(delta): 
	if(Input.is_action_just_pressed("shoot") and can_shoot):
		can_shoot = false
		ObjectMaker.create_bullet(rotation - 1.5708, 300, shoot_marker.global_position)
		

#Called every physics frame (for consistent movement due to velocity).
#not related to game FPS
func _physics_process(delta):
	
	#region Movement
	if(Input.is_action_pressed("move_left")):
		velocity.x = -MOVEMENT_SPEED * delta
	elif(Input.is_action_pressed("move_right")):
		velocity.x = MOVEMENT_SPEED * delta
	else: 
		velocity.x = 0 
		
	if(Input.is_action_pressed("move_up")):
		velocity.y = -MOVEMENT_SPEED * delta
	elif(Input.is_action_pressed("move_down")):
		velocity.y = MOVEMENT_SPEED * delta
	else:
		velocity.y = 0
	#endregion
	
	#region Rotation
	if(Input.is_action_pressed("rotate_left")):
		rotation_degrees += -ROTATION_SPEED * delta
	elif(Input.is_action_pressed("rotate_right")):
		rotation_degrees += ROTATION_SPEED * delta
	#endregion
	
	move_and_slide()
	position.x = clampf(position.x, 0, screen_size.x)
	position.y = clampf(position.y, 0, screen_size.y)

func _on_bullet_cool_down_timeout():
	can_shoot = true 

func _on_hit_box_area_entered(area: Area2D) -> void:
	print("Player got hit!")
	SignalManager.on_player_hit.emit()
	GameManager.game_over = true 
