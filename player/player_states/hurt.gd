extends PlayerState

func exit() -> void:
	player._animation_player.speed_scale = 1.0

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_slide"):
		player.buffered_attack = "game_slide"
		if not player.lock_buffer:
			finished.emit(SLIDE)
			
func enter(_previous_state_path: String, _data := {'hitstun': 1.0}) -> void:
	player._hitbox_manager._clear_hitboxes()
	player.velocity = Vector3(0,0,0)
	pass
	#if input_direction_x<0:
		#player.facing_direction = 1
	#elif input_direction_x>0:
		#player.facing_direction = 0
	player._animation_player.speed_scale = 1.0/_data['hitstun']
	player._animation_player.play("player_hurt")
	player._animation_player.seek(0.01,true)

func update(_delta: float) -> void:
	if not player.lock_buffer and player.buffered_attack=="game_slide":
		player.lock_buffer = true
		finished.emit(SLIDE)
	if player.facing_direction as bool:
		player._animated_sprite.set_rotation_degrees(Vector3(0,-180,0))
	else:
		player._animated_sprite.set_rotation_degrees(Vector3(0,0,0))
	#player._animated_sprite.set_flip_h(player.facing_direction as bool)

func physics_update(delta: float) -> void:
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#if input_direction_x<0:
		#player.facing_direction = 1
	#elif input_direction_x>0:
		#player.facing_direction = 0
	var dir := 1
	if player.facing_direction == 1:
		dir = -1
	if(player._hitstop_manager.hitstop_timer.is_stopped()):
		player.velocity.x = player.hurt_speed * -dir
		player.velocity.y += player.gravity * delta
		player.move_and_slide()
	
	#if not player.is_on_floor():
		#finished.emit(FALLING)
	#elif Input.is_action_just_pressed("game_attack1"):
		#finished.emit(LIGHTATTACK1)
	#elif Input.is_action_just_pressed("game_attack2"):
		#finished.emit(HEAVYATTACK1)
	#elif is_equal_approx(input_direction_x, 0.0):
		#finished.emit(IDLE)
