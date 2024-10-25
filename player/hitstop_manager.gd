class_name HitstopManger extends Node

var player

@onready var hitstop_timer := Timer.new()

func _unhitstop() -> void:
	player._animation_player.play()
	hitstop_timer.stop()

func set_hitstop(time: float):
	player._animation_player.pause()
	player.set_velocity(Vector3(0,0,0))
	#player.fake_root_motion = 0
	hitstop_timer.wait_time = time
	hitstop_timer.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent() as Player
	add_child(hitstop_timer)
	hitstop_timer.one_shot = true
	hitstop_timer.connect("timeout", _unhitstop)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
