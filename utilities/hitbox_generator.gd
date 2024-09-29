@tool
extends EditorScript

func parse_AABB(box: String) -> AABB:
	#print(box)
	#print(var_to_str(AABB()))
	#print(str_to_var(box))
	return AABB()

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	#print("TEST")
	var data_to_send = {"hitboxes": [var_to_str(AABB(Vector3(0,0,0), Vector3(1,1,1))), AABB(Vector3(2,2,0), Vector3(1,2,1))]}
	var json_string = JSON.stringify(data_to_send)
	#print(json_string)
	var jsontest := JSON.new()
	jsontest.parse(json_string)
	parse_AABB(jsontest.data['hitboxes'][0])
	print("SDF")
	#print(get_scene())
	# `parent` could be any node in the scene.
	var designer = get_scene().get_node('HitboxDesigner')
	
	var boxes := Dictionary()
	boxes['hitboxes'] = []
	boxes['hurtboxes'] = []
	
	var n_hitboxes := 0
	var n_hurtboxes := 0
	
	for i in designer.get_children():
		var what := i as CollisionShape3D
		var shape := what.get_shape() as BoxShape3D
		var bounds := AABB(what.position-Vector3(0.5,0.5,0)*shape.size, shape.size)
		print(bounds)
		if what.name.containsn("Hitbox"):
			boxes['hitboxes'].append({"id": n_hitboxes, "aabb": var_to_str(bounds), "damage":1, "hitstop": 0.75, "hitstun": 0.5})
			n_hitboxes += 1
		if what.name.containsn("Hurtbox"):
			boxes['hitboxes'].append({"id": n_hurtboxes, "aabb": var_to_str(bounds)})
			n_hurtboxes += 1
	print(JSON.stringify(boxes))
	#var node = Node3D.new()
	#parent.add_child(node)
	# The line below is required to make the node visible in the Scene tree dock
	# and persist changes made by the tool script to the saved scene file.
	#node.owner = get_scene()
