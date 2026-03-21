extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine

var shield_scene = load("res://scenes/shield.tscn")
var shield

func on_process(delta : float):
	animated_sprite_2d.play('block')


func on_physics_process(delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, character_body_2d.slow_down_speed * delta / 2)
	if Input.is_action_pressed(character_body_2d.input_prefix + "move_right"):
		if character_body_2d.direction != 1:
			character_body_2d.scale.x *= -1
			character_body_2d.direction = 1
	if Input.is_action_pressed(character_body_2d.input_prefix + "move_left"):
		if character_body_2d.direction != -1:
			character_body_2d.scale.x *= -1
			character_body_2d.direction = -1
	
	# Check for transitions to other states
	if not(Input.is_action_pressed(character_body_2d.input_prefix + "block")):
		state_machine.transition_to('idle')


func enter():
	shield = shield_scene.instantiate()
	shield.position.x = 5
	character_body_2d.add_child(shield)


func exit():
	if shield:
		shield.queue_free()
