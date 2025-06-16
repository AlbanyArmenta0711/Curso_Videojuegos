extends CanvasLayer
var can_press_space

func _ready():
	visible = false 
	SignalManager.on_player_hit.connect(on_player_hit)
	can_press_space = false
	
func _process(delta):
	if(Input.is_action_just_pressed("shoot") and can_press_space):
		print("Starting game again")
		can_press_space = false 
		get_tree().paused = false 
		GameManager.on_return_to_menu()
	
func on_player_hit():
	get_tree().paused = true 
	visible = true 
	can_press_space = true
