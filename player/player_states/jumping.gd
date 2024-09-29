extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y = player.jump_impulse
	player._animation_player.play("player_jump")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("game_left", "game_right")
	player.velocity.x = player.velocity.x + player.air_accel * input_direction_x * delta
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.velocity.y <= 0:
		finished.emit(FALLING)
