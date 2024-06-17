extends Area2D

class_name FallingObjectBase

var _DIRECTION = Vector2.DOWN
var _falling_speed: float = 0.0 : set = set_falling_speed, get = get_falling_speed
var _score: int = 0 : set = set_score, get = get_score

func _process(delta):
	fall(delta)

func fall(delta):
	position += _DIRECTION * delta * _falling_speed
	
func custom_init(falling_speed: float, score: int):
	_falling_speed = falling_speed
	_score = score 
	
func set_score(score: int):
	_score = score

func get_score() -> int:
	return _score	
	 
func set_falling_speed(new_falling_speed: float):
	_falling_speed = new_falling_speed

func get_falling_speed() -> float:  
	return _falling_speed

func _on_screen_exited():
	queue_free()
