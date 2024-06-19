extends Area2D

@onready var particles = $CPUParticles2D
@onready var sprite_2d = $AnimatedSprite2D
@onready var sound_player = $SoundPlayer

const SCORE : int = 5

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	SignalManager.on_score_grabbed.emit(SCORE)
	SoundsManager.play_sound(sound_player, SoundsManager.SOUND_PICKUP)
	sprite_2d.visible = false
	particles.emitting = true 


func _on_cpu_particles_2d_finished():
	queue_free()
