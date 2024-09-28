class_name Player extends CharacterBody3D

@export var speed := 5.0
@export var gravity := -9.8*3
@export var jump_impulse := 12.0

@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
#@onready var _animated_sprite = $AnimatedSprite3D
@onready var _animation_player := $AnimationPlayer
