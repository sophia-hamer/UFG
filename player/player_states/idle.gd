extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.x = 0.0
	player._animation_player.play("player_idle")
	#player._animated_sprite.play("default")

func update(_delta: float) -> void:
	player._animated_sprite.set_flip_h(player.facing_direction as bool)

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("game_jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("game_left") or Input.is_action_pressed("game_right"):
		finished.emit(RUNNING)
