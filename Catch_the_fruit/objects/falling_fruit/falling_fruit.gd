extends FallingObjectBase

var _DIRECTION: Vector2 = Vector2.DOWN
var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Falling speed:" + str(get_falling_speed()))
	#set_falling_speed(200.0)
	#print("New falling speed: " + str(get_falling_speed()))
	var random_speed = _rng.randf_range(250.0, 450.0)
	set_falling_speed(random_speed)
	print("New falling speed: " + str(get_falling_speed()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += _DIRECTION * delta * get_falling_speed()
	

func _on_falling_fruit_body_entered(body):
	print("Collided with something")
