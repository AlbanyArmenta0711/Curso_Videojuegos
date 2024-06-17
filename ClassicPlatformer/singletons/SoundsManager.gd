extends Node

#Keys for sounds
const SOUND_HURT = "hurt"
const SOUND_JUMP = "jump"
const SOUND_LAND = "land"
const SOUND_PICKUP = "pickup"

#Dictionary for sound management
var SOUNDS = {
	SOUND_HURT : preload("res://assets/sounds/damage.wav"),
	SOUND_JUMP : preload("res://assets/sounds/jump.wav"),
	SOUND_LAND : preload("res://assets/sounds/land.wav"),
	SOUND_PICKUP : preload("res://assets/sounds/pickup.wav")
}

func play_sound(audio_player: AudioStreamPlayer2D, clip_key: String):
	if SOUNDS.has(clip_key):
		audio_player.stream = SOUNDS[clip_key]
		audio_player.play()
