extends FallingObjectBase

var _rng = RandomNumberGenerator.new()

func _ready():
	var random_speed = _rng.randf_range(250.0, 500.0)
	custom_init(random_speed, 0)


func _on_spikes_body_entered(body):
	if body.name == "Catcher":
		queue_free()
		SignalManager.on_spikes_caught.emit()
