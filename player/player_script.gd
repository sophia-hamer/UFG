class_name Player extends CharacterBody3D

@export var speed := 5.0
@export var gravity := -9.8*3
@export var jump_impulse := 12.0
@export var health := 100
@export var dead := false

@export var facing_direction := 0

@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _animated_sprite = $AnimatedSprite3D
@warning_ignore("UNUSED_PRIVATE_CLASS_VARIABLE")
@onready var _animation_player := $AnimationPlayer
@onready var _walking_audio := $walkingAudio
@onready var _jump_audio := $jumpAudio
@onready var _health_bar := $ProgressBar

func update_health(damage):
	health = health - damage
	_health_bar.value = health
	if(health <= 0):
		dead = true
	
