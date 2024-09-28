class_name StateMachine extends Node

@export var initial_state: State = null

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
	state.handle_input(event)

# Called every frame
func _process(delta: float) -> void:
	state.update(delta)

# Called every physics frame
func _physics_process(delta: float) -> void:
	state.physics_update(delta)

# Called when a state signals that it should be called
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
