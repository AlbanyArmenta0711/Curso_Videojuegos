extends FallingObjectBase

class_name FallingFruit

var _rng = RandomNumberGenerator.new()
var _fruit_score:int = 5

func _ready():
	var random_speed = _rng.randf_range(250.0, 450.0)
	custom_init(random_speed, _fruit_score)

func _on_falling_fruit_body_entered(body):
	if body.name == "Catcher":
		queue_free()
		SignalManager.on_fruit_caught.emit(_fruit_score)
