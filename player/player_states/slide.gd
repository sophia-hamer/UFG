extends PlayerState

var saved_player_layer := 2
var saved_player_mask := 2
var saved_area3d_mask := 1

func exit() -> void:
	player._hurtbox.set_collision_mask(saved_area3d_mask)
	player.set_collision_layer(saved_player_layer)
	player.set_collision_mask(saved_player_mask)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	var input_direction_x := Input.get_axis("game_left", "game_right")
	if input_direction_x<0:
		player.facing_direction = 1
	elif input_direction_x>0:
		player.facing_direction = 0
		
	saved_area3d_mask = player._hurtbox.get_collision_mask()
	saved_player_layer = player.get_collision_layer() 
	saved_player_mask = player.get_collision_mask() 
	player._hurtbox.set_collision_mask(0)
	player.set_collision_layer(0)
	player.set_collision_mask(1)
	
	player._animation_player.play("player_slide")

func update(_delta: float) -> void:
	if player.facing_direction as bool:
		player._animated_sprite.set_rotation_degrees(Vector3(0,-180,0))
	else:
		player._animated_sprite.set_rotation_degrees(Vector3(0,0,0))
	#player._animated_sprite.set_flip_h(player.facing_direction as bool)

func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("game_jump"):
		finished.emit(JUMPING)
		
func physics_update(delta: float) -> void:
	#var input_direction_x := Input.get_axis("game_left", "game_right")
	#if input_direction_x<0:
		#player.facing_direction = 1
	#elif input_direction_x>0:
		#player.facing_direction = 0
	var dir := 1
	if player.facing_direction == 1:
		dir = -1
	player.velocity.x = player.slide_speed * dir
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	#elif Input.is_action_just_pressed("game_attack1"):
		#finished.emit(LIGHTATTACK1)
	#elif Input.is_action_just_pressed("game_attack2"):
		#finished.emit(HEAVYATTACK1)
	#elif is_equal_approx(input_direction_x, 0.0):
		#finished.emit(IDLE)
