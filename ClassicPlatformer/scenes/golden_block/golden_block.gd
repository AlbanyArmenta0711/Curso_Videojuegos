extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@export var fruit_scene : PackedScene

var hit : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hit: 
		var new_fruit = fruit_scene.instantiate()
		get_parent().add_child(new_fruit)
		new_fruit.global_position.y = self.global_position.y - 15.0
		new_fruit.global_position.x = self.global_position.x 
		hit = false

func _on_area_2d_area_entered(area):
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d,"scale",Vector2(2,2),0.3)
	tween.tween_property(sprite_2d,"scale",Vector2(0,0),0.3)
	hit = true 
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	queue_free()
