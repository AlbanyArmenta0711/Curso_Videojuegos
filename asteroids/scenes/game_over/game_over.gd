extends CanvasLayer
var can_press_space

@onready var anim_player = $AnimationPlayer
@onready var continue_label = $MarginContainer/VBoxContainer/ContinueLabel

func _ready():
	visible = false 
	SignalManager.on_player_hit.connect(on_player_hit)
	continue_label.visible = false
	
func _process(delta):
	if(Input.is_action_just_pressed("shoot") and can_press_space):
		print("Starting game again")
		can_press_space = false 
		get_tree().paused = false 
		GameManager.on_return_to_menu()
	
func on_player_hit():
	get_tree().paused = true 
	visible = true 
	anim_player.play("game_over_text_anim")
	continue_label.visible = true
	anim_player.queue("modulate_continue")
	can_press_space = true
