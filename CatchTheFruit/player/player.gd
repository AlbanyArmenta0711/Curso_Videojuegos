extends CharacterBody2D

#Propiedades de los componentes
@onready var sprite2d = $Sprite2D

@export var MOVEMENT_SPEED: float = 150.0
var DASH_SPEED: float = MOVEMENT_SPEED * 3

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(on_game_over)
	
func _process(delta):
	move_and_slide()
	if(Input.is_action_pressed("movement_left")):
		sprite2d.flip_h = true 
		if(Input.is_action_pressed("dash")):
			velocity.x = -DASH_SPEED
		else: 
			velocity.x = -MOVEMENT_SPEED
	elif (Input.is_action_pressed("movement_right")):
		sprite2d.flip_h = false
		if(Input.is_action_pressed("dash")):
			velocity.x = DASH_SPEED
		else: 
			velocity.x = MOVEMENT_SPEED
	else: 
		velocity.x = 0 
	var max_pos_x = get_viewport().size.x
	position.x = clampf(position.x, 0, max_pos_x)

func on_game_over():
	set_process(false)
