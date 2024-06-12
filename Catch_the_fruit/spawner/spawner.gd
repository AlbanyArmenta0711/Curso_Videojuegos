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
	add_child(new_fruit)


func _on_spikes_timer_timeout():
	var new_spike= spike.instantiate()
	add_child(new_spike)
