extends CharacterBody2D

@onready var player_ref : Player
@onready var shoot_marker = $Marker2D

func _ready():
	#Player group must be created and assigned to Player scene
	player_ref = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	look_at(player_ref.global_position) 

func _on_bullet_cool_down_timeout():
	ObjectMaker.create_enemy_bullet(rotation, shoot_marker.global_position)
