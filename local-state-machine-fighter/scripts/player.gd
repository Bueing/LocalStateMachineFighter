extends CharacterBody2D

@export var running_speed : int = 150
@export var jump_velocity : int = 400
@export var slow_down_speed : int = 600

@export var input_prefix : String

var direction : int = 1

func _physics_process(delta):
	move_and_slide()
