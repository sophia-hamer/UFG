extends PlayerState

func end_attack(_new_state: String) -> void:
	finished.emit(_new_state)

func exit() -> void:
	player.fake_root_motion = 0
	player._hitbox_manager._clear_hitboxes()
	pass
	
func enter(_previous_state_path: String, _data := {}) -> void:
	player._hitbox_manager._clear_hitboxes()
	player._animation_player.play("player_jump_light")


## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass
	
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
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * _delta
	#player.move_and_slide()
