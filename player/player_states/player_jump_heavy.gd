extends PlayerState

func end_attack(_new_state: String) -> void:
	finished.emit(_new_state)

func exit() -> void:
	player.fake_root_motion = 0
	player._hitbox_manager._clear_hitboxes()
	pass
	
func enter(_previous_state_path: String, _data := {}) -> void:
	player._hitbox_manager._clear_hitboxes()
	player.velocity.x = 0
	player.velocity.z = 0
	player.velocity.y = 0
	player._animation_player.play("player_jump_heavy")


## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	
	player.velocity.x = player.velocity.x + player.air_accel * player.input_axis_x * _delta
	player.velocity.z = player.velocity.z + player.air_accel * player.input_axis_z * _delta
	player.velocity.y += player.gravity * _delta * 0.01
	player.move_and_slide()
	
	if player.is_on_floor():
		if is_equal_approx(player.input_axis_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * _delta
	#player.move_and_slide()
