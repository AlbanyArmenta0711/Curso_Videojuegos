extends FallingObjectBase

var _rng = RandomNumberGenerator.new()
var _fruit_score:int = 5

func _init():
	var random_speed = _rng.randf_range(250.0, 450.0)
	print("New falling speed: " + str(random_speed))
	super(random_speed, _fruit_score)

func _on_falling_fruit_body_entered(body):
	if body.name == "Catcher":
		print("Collided with Catcher")
		SignalManager.on_fruit_caught.emit(_fruit_score)
