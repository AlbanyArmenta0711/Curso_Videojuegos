extends FallingObjectBase

var _rng = RandomNumberGenerator.new()
var falling_speed: float = 0.0

func _ready():
	falling_speed = _rng.randf_range(150.0, 600.0)
	custom_init(falling_speed, -10)

func _on_spikes_entered(body):
	if body.name == "Player":
		SignalManager.on_spikes_caught.emit()
		queue_free()
