extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area is Area3D:
		var other := area.get_parent_node_3d() as Player
		if other:
			other.scale = Vector3(1.5,1.5,1.5)
		queue_free()
