class_name Player extends CharacterBody3D

@export var is_ai := false

@export var speed := 3
@export var speed_z := 3
@export var slide_speed := 10.0
@export var hurt_speed := 1.0
@export var big_hurt_speed := 2.0
@export var gravity := -9.8*3
@export var jump_impulse := 14.0
@export var air_accel := 2.0
@export var fake_root_motion := 0.0
@export var facing_direction := 0
@export var HP := 20.0
@export var HP_max := 20.0


@export var lock_buffer := false
@export var buffered_attack := ""

@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _animated_sprite := $AnimatedSprite3D
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _animation_player := $AnimationPlayer
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _hitbox_manager := $HitboxManager
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _state_machine := $StateMachine
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _hitstop_manager := $HitstopManager
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _hurtbox := $Hurtbox

@onready var default_sprite_pos := _animated_sprite.position as Vector3
@onready var input_axis_x := 0.0
@onready var input_axis_z := 0.0
