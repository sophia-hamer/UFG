class_name HitboxManager extends Node

var parent_player : Player

func _clear_hitboxes() -> void:
	for i in parent_player.get_children():
		if i is Hitbox:
			i.queue_free()
	

func _spawn_hitboxes(data: String) -> void:
	_clear_hitboxes()
	if not data:
		return
	var jsontest := JSON.new()
	jsontest.parse(data)
	for i in range(len(jsontest.data['hitboxes'])):
		var bounding_box := str_to_var(jsontest.data['hitboxes'][i]['aabb']) as AABB
		var hitbox = Hitbox.new()
		hitbox.name = str(i)
		hitbox.data = jsontest.data['hitboxes'][i]
		hitbox._initialize(bounding_box, parent_player, str(i))
		parent_player.add_child(hitbox)
		pass
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent_player = get_parent() as Player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
