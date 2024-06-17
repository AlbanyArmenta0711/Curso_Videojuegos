extends Marker2D

@export var fruit : PackedScene
@export var spikes : PackedScene

var _rng = RandomNumberGenerator.new()
const OFFSET : int = 60 

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func on_game_over():
	queue_free()

func _on_fruit_timer_timeout():
	var new_fruit = fruit.instantiate()
	add_child(new_fruit)
	var random_x = _rng.randf_range(OFFSET, get_viewport().size.x - OFFSET)
	new_fruit.global_position.x = random_x 
	
func _on_spike_timer_timeout():
	var new_spikes = spikes.instantiate()
	add_child(new_spikes)
	var random_x = _rng.randf_range(OFFSET, get_viewport().size.x - OFFSET)
	new_spikes.global_position.x = random_x 
