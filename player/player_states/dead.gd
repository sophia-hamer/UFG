extends PlayerState

@onready var despawn_timer := Timer.new()

func _please() -> void:
	if player.is_ai:
		var newguy1 := preload("res://player.tscn").instantiate()
		var newguy2 := preload("res://player.tscn").instantiate()
		var rng := RandomNumberGenerator.new()
		newguy1.position=(Vector3(rng.randf_range(-20,20),10,rng.randf_range(-20,20)))
		newguy2.position=(Vector3(rng.randf_range(-20,20),10,rng.randf_range(-20,20)))
		newguy1.set_name("badguy")
		newguy2.set_name("badguy")
		newguy1.is_ai = true
		newguy2.is_ai = true
		get_tree().current_scene.add_child(newguy1)
		get_tree().current_scene.add_child(newguy2)
		player.queue_free()

func _ready() -> void:
	await owner.ready
	player = owner as Player
	add_child(despawn_timer)
	despawn_timer.one_shot = true
	despawn_timer.connect("timeout",_please)

func enter(_previous_state_path: String, _data := {}) -> void:
	player._hitbox_manager._clear_hitboxes()
	player.set_collision_layer(0)
	player.set_collision_mask(1)
	player._hurtbox.set_collision_layer(0)
	player._hurtbox.set_collision_mask(0)
	despawn_timer.wait_time = 3.0
	despawn_timer.start()
	player.velocity = Vector3(0,0,0)
	pass
	#if input_direction_x<0:
		#player.facing_direction = 1
	#elif input_direction_x>0:
		#player.facing_direction = 0
	player._animation_player.play("player_dead")
	player._animation_player.seek(0.01,true)
	
	if player.is_ai:
		var other := get_node("../../../Real") as Player
		other.HP = min(other.HP+1,other.HP_max)
		other._health_bar.value = other.HP

func update(_delta: float) -> void:
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
