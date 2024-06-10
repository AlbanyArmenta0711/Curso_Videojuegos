extends CharacterBody2D
"""
	Class that represents the catcher node
"""
class_name Catcher

"""
Initiliaze properties of node when ready (once they are loaded to avoid errors)
"""
@onready var sprite_2d = $Sprite2D

"""
Constants for playable parameters
"""
const MOVEMENT_SPEED: float = 230.0 
const DASH_SPEED: float = 380.0 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	_get_input()
	move_and_slide()
	
func _get_input() -> void :
	velocity.x = 0 # if not done, player will keep sliding
	#Check for arrow keys. Configure this at Project>Project Settings>Input Map
	if Input.is_action_pressed("movement_left"):
		if Input.is_action_pressed("dash"):
			velocity.x = -DASH_SPEED
		else:
			velocity.x = -MOVEMENT_SPEED
		sprite_2d.flip_h = true 
	if Input.is_action_pressed("movement_right"):
		if Input.is_action_pressed("dash"):
			velocity.x = DASH_SPEED
		else:
			velocity.x = MOVEMENT_SPEED
		sprite_2d.flip_h = false
		
	#Clamp to screen size so character does not get out of screen
	#position.x = clampf(position.x, 0, get_viewport().size.x)
		
