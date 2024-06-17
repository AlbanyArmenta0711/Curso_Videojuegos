extends FallingObjectBase

var _rng = RandomNumberGenerator.new()
var falling_speed: float = 0.0
var score: int = 5 

func _ready():
	falling_speed = _rng.randf_range(150.0, 600.0)
	custom_init(falling_speed, score)


func _on_fruit_entered(body):
	if body.name == "Player":
		SignalManager.on_fruit_caught.emit(get_score())
		queue_free()
