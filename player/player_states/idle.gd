extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	player._hitbox_manager._clear_hitboxes()
	player._animation_player.play("player_idle")
	#player._animated_sprite.play("default")

func update(_delta: float) -> void:
	if player.facing_direction as bool:
		player._animated_sprite.set_rotation_degrees(Vector3(0,-180,0))
	else:
		player._animated_sprite.set_rotation_degrees(Vector3(0,0,0))

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_jump"):
		finished.emit(JUMPING)
	elif _event.is_action_pressed("game_attack1"):
		finished.emit(LIGHTATTACK1)
	elif _event.is_action_pressed("game_attack2"):
		finished.emit(HEAVYATTACK1)
	elif _event.is_action_pressed("game_slide"):
		finished.emit(SLIDE)

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif (not is_equal_approx(player.input_axis_x, 0.0)) or (not is_equal_approx(player.input_axis_z, 0.0)):
		finished.emit(RUNNING)
