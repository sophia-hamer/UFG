extends PlayerState

func end_attack(_new_state: String) -> void:
	finished.emit(_new_state)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	print("ANDFJK")
	player._animation_player.play("player_light_1")

func physics_update(_delta: float) -> void:
	pass
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * _delta
	#player.move_and_slide()
