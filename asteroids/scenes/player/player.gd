extends CharacterBody2D

@onready var shoot_marker = $BulletMark

@export var bullet : PackedScene 

@export var MOVEMENT_SPEED = 150.0
@export var ROTATION_SPEED = 100.0

var can_shoot : bool = true 

#Called when the node enters the scene tree
func _ready():
	pass

#Called every game frame
func _process(delta): 
	if(Input.is_action_just_pressed("shoot")):
		can_shoot = false
		
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.global_position.x = shoot_marker.global_position.x
		new_bullet.global_position.y = shoot_marker.global_position.y

#Called every physics frame (for consistent movement due to velocity).
#not related to game FPS
func _physics_process(delta):
	move_and_slide()
	
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

func _on_bullet_cool_down_timeout():
	can_shoot = true 
