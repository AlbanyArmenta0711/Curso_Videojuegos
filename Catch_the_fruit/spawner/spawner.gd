extends Marker2D

@export var fruit : PackedScene
@export var spike : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fruit_timer_timeout():
	var new_fruit = fruit.instantiate()
	print("Fruta generada")
	add_child(new_fruit)
	
	var rng = RandomNumberGenerator.new()
	var random_pos_x = rng.randf_range(30, get_viewport().size.x - 30)
	new_fruit.global_position.x = random_pos_x


func _on_spikes_timer_timeout():
	var new_spike= spike.instantiate()
	add_child(new_spike)
	var rng = RandomNumberGenerator.new()
	var random_pos_x = rng.randf_range(30, get_viewport().size.x - 30)
	new_spike.global_position.x = random_pos_x
