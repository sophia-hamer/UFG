class_name StateMachine extends Node

@export var initial_state: State = null
@onready var player := owner as Player

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()

# Called on spawn
func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")

# Called when input
func _unhandled_input(event: InputEvent) -> void:
	if player.is_ai:
		return
	player.input_axis_x = Input.get_axis("game_left", "game_right")
	player.input_axis_z = Input.get_axis("game_up", "game_down")
	if(not (is_equal_approx(player.input_axis_x, 0.0) and is_equal_approx(player.input_axis_z, 0.0))):
		player.input_axis_x /= sqrt((player.input_axis_x)**2+(player.input_axis_z)**2)
		player.input_axis_z /= sqrt((player.input_axis_x)**2+(player.input_axis_z)**2)
	pass
	#event = InputEventAction.new()
	#event.action = "game_jump"
	state.handle_input(event)

# Called every frame
func _process(delta: float) -> void:
	var thing := InputEventAction.new()
	thing.action = "game_attack2"
	thing.pressed = true
	if player.is_ai:
		pass
		#state.handle_input(thing)
	state.update(delta)

# Called every physics frame
func _physics_process(delta: float) -> void:
	state.physics_update(delta)

# Called when a state signals that it should be called
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	player._hitbox_manager._clear_hitboxes()
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)

func _just_stop() -> void:
	owner.velocity = Vector3(0,0,0)
	player.hurt_speed = 0

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	#print("HIT BY "+str(area))
	#print(area.get_parent() is Player)
	if area.get_parent() is Player and area.get_parent() != player:
		if area.name == "Hurtbox":
			return
		if not area is Hitbox:
			return
		var hitbox := area as Hitbox
		var other := area.get_parent() as Player
		player.facing_direction = 1
		if other.position.x>player.position.x:
			player.facing_direction = 0
		player.HP -= hitbox.data['damage']
		print(hitbox.data['damage'])
		print(player.HP)
		var killed := 1
		if player.HP<=0:
			killed = 3
			_transition_to_next_state("Dead", {'hitstun': hitbox.data['hitstun']})
		else:
			if hitbox.data['damage']<=1:
				_transition_to_next_state("Hurt", {'hitstun': hitbox.data['hitstun']})
			else:
				_transition_to_next_state("BigHurt", {'hitstun': hitbox.data['hitstun']})
				
		player._hitstop_manager.set_hitstop(hitbox.data['hitstop']*1.7*killed)
		other._hitstop_manager.set_hitstop(hitbox.data['hitstop']*1.7*killed)
	pass # Replace with function body.
