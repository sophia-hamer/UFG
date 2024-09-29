extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	player._animation_player.play("player_fall")

func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("game_left", "game_right")
	player.velocity.x = player.velocity.x + player.air_accel * input_direction_x * _delta
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
