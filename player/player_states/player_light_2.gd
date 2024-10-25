extends PlayerState

func end_attack(_new_state: String) -> void:
	finished.emit(_new_state)

func exit() -> void:
	player.fake_root_motion = 0
	player.buffered_attack = ""
	player.lock_buffer = false
	pass
	
func enter(_previous_state_path: String, _data := {}) -> void:
	player._hitbox_manager._clear_hitboxes()
	player._animation_player.play("player_light_2")


## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_slide"):
		player.buffered_attack = "game_slide"
		if not player.lock_buffer:
			finished.emit(SLIDE)
	if _event.is_action_pressed("game_attack1"):
		player.buffered_attack = "game_attack1"
		if not player.lock_buffer:
			finished.emit(LIGHTATTACK3)
	if _event.is_action_pressed("game_attack2"):
		player.buffered_attack = "game_attack2"
		if not player.lock_buffer:
			finished.emit(HEAVYATTACK2)
	pass

func update(_delta: float) -> void:
	if not player.lock_buffer and player.buffered_attack=="game_slide":
		player.lock_buffer = true
		finished.emit(SLIDE)
	if not player.lock_buffer and player.buffered_attack=="game_attack1":
		player.lock_buffer = true
		finished.emit(LIGHTATTACK3)
	if not player.lock_buffer and player.buffered_attack=="game_attack2":
		player.lock_buffer = true
		finished.emit(HEAVYATTACK2)
		
func physics_update(_delta: float) -> void:
	pass
	var dir := 1
	if player.facing_direction as bool:
		dir = -1
	if(player._hitstop_manager.hitstop_timer.is_stopped()):
		player.set_velocity(player.fake_root_motion*Vector3(dir,0,0))
		player.move_and_slide()
	if not player.is_on_floor():
		finished.emit(FALLING)
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * _delta
	#player.move_and_slide()
