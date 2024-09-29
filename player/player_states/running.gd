extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	player._animation_player.play("player_walk_forward")

func update(_delta: float) -> void:
	if player.facing_direction as bool:
		player._animated_sprite.set_rotation_degrees(Vector3(0,-180,0))
	else:
		player._animated_sprite.set_rotation_degrees(Vector3(0,0,0))
	#player._animated_sprite.set_flip_h(player.facing_direction as bool)

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("game_left", "game_right")
	if input_direction_x<0:
		player.facing_direction = 1
	elif input_direction_x>0:
		player.facing_direction = 0
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("game_jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("game_attack1"):
		finished.emit(LIGHTATTACK1)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
