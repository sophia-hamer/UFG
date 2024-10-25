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

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_jump"):
		finished.emit(JUMPING)
	elif _event.is_action_pressed("game_attack1"):
		finished.emit(LIGHTATTACK1)
	elif _event.is_action_pressed("game_attack2"):
		finished.emit(HEAVYATTACK1)
	elif _event.is_action_pressed("game_slide"):
		finished.emit(SLIDE)
		
func physics_update(delta: float) -> void:
	var input_direction_x := player.input_axis_x
	var input_direction_z := player.input_axis_z
	if input_direction_x<0:
		player.facing_direction = 1
	elif input_direction_x>0:
		player.facing_direction = 0
	player.velocity.x = player.speed * input_direction_x
	player.velocity.z = player.speed_z * input_direction_z
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif is_equal_approx(player.input_axis_x, 0.0) and is_equal_approx(player.input_axis_z, 0.0):
		finished.emit(IDLE)
