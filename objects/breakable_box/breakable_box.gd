extends CharacterBody3D


@export var gravity := -9.8*3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()

func _on_area_3d_area_shape_entered(_area_rid: RID, _area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	var player := _area.get_parent_node_3d() as Player
	var area := _area as Hitbox
	if player and area:
		player._hitstop_manager.set_hitstop(area.data['hitstop'])
	#queue_free()
	pass # Replace with function body.
