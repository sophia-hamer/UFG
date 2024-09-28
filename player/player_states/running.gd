extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	#player.animation_player.play("run")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("game_left", "game_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("game_jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
