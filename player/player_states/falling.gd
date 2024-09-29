extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	player._animation_player.play("player_fall")

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_attack1"):
		finished.emit(JUMPLIGHT)
	elif _event.is_action_pressed("game_attack2"):
		finished.emit(JUMPHEAVY)
		
func physics_update(_delta: float) -> void:
	var input_direction_x := player.input_axis_x
	var input_direction_z := player.input_axis_z
	player.velocity.x = player.velocity.x + player.air_accel * input_direction_x * _delta
	player.velocity.z = player.velocity.z + player.air_accel * input_direction_z * _delta
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
