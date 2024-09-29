extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y = player.jump_impulse
	player._animation_player.play("player_jump")

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_attack1"):
		finished.emit(JUMPLIGHT)
	elif _event.is_action_pressed("game_attack2"):
		finished.emit(JUMPHEAVY)
		
func physics_update(delta: float) -> void:
	var input_direction_x := player.input_axis_x
	var input_direction_z := player.input_axis_z
	player.velocity.x = player.velocity.x + player.air_accel * input_direction_x * delta
	player.velocity.z = player.velocity.z + player.air_accel * input_direction_z * delta
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.velocity.y <= 0:
		finished.emit(FALLING)
