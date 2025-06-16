extends Control

func _on_start_button_button_down() -> void:
	GameManager.on_game_start()

func _on_exit_button_button_down() -> void:
	GameManager.on_exit()
