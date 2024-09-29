class_name Hitbox extends Area3D

func _initialize(bounding_box: AABB, player: Player, _hitbox_name: String) -> void:
	
	var scale_factor := Vector3(1,1,1)
	if player.facing_direction == 1:
		scale_factor *= Vector3(-1,1,1)

	var asdf := BoxShape3D.new()
	asdf.size = bounding_box.size
	var collision_shape := CollisionShape3D.new()
	var collision_box := BoxShape3D.new()
	collision_box.size = bounding_box.size
	collision_shape.set_shape(collision_box)
	self.add_child(collision_shape)
	
	var last_transform := Transform3D(Basis.from_scale(Vector3(1,1,1)), (bounding_box.position+bounding_box.size*Vector3(0.5,0.5,0.5))*scale_factor)
	collision_shape.set_transform(  player.transform*last_transform  )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_shape_entered(_area_rid: RID, _area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	print("WHAT")
	pass # Replace with function body.
