class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const LIGHTATTACK1 = "LightAttack1"
const LIGHTATTACK2 = "LightAttack2"
const LIGHTATTACK3 = "LightAttack3"
const HEAVYATTACK1 = "HeavyAttack1"
const HEAVYATTACK2 = "HeavyAttack2"
const HEAVYATTACK3 = "HeavyAttack3"
const JUMPLIGHT = "JumpLight"
const JUMPHEAVY = "JumpHeavy"
const SLIDE = "Slide"
const HURT = "Hurt"
const BIGHURT = "BigHurt"
const DEAD = "Dead"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
