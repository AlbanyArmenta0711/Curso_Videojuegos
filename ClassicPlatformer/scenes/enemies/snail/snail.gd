extends CharacterBody2D

@onready var floor_detection  = $FloorDetection
@onready var sprite_2d = $AnimatedSprite2D
@onready var wall_detection = $WallDetection

const GRAVITY : float = 500.0
const MOVEMENT_SPEED : float = 20.0

enum FACING_DIRECTION  {LEFT = -1, RIGHT = 1}
var facing : FACING_DIRECTION = FACING_DIRECTION.LEFT
var destroyed : bool = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.x = MOVEMENT_SPEED * facing
		
		if wall_detection.is_colliding() or not floor_detection.is_colliding():
			flip_me()
			
	if not sprite_2d.is_playing() and destroyed: 
		queue_free()
		
func flip_me():
	sprite_2d.flip_h = !sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1 
	wall_detection.target_position.x = wall_detection.target_position.x * -1 
	if facing == FACING_DIRECTION.LEFT: 
		facing = FACING_DIRECTION.RIGHT
	else:
		facing = FACING_DIRECTION.LEFT


func _on_hit_box_area_entered(area):
	print("Aplastado")
	sprite_2d.animation = "destroy"
	destroyed = true 
