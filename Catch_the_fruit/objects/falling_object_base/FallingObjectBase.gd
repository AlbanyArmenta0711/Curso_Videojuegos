extends Area2D

class_name FallingObjectBase


const _DIRECTION: Vector2 = Vector2.DOWN
var _falling_speed: float = 0.0 : set = set_falling_speed , get = get_falling_speed
var _score: int = 1 : set = set_score_value , get = get_score_value

#Custom class constructor for defining score of object and falling speed
func custom_init(falling_speed: float, score: int):
	_falling_speed = falling_speed
	_score = score 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += _DIRECTION * delta * _falling_speed
	
func set_falling_speed(falling_speed: float) -> void:
	_falling_speed = falling_speed

func get_falling_speed() -> float: 
	return _falling_speed

func set_score_value(score_value: int) -> void:
	_score = score_value
	
func get_score_value() -> int:
	return _score 


func _on_screen_exited():
	print("Eliminando!")
	queue_free()
