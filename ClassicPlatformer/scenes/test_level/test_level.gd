extends Node2D

@onready var player = $Player
@onready var player_cam = $PlayerCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_cam.position = player.position
