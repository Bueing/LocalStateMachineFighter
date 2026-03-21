extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine

func on_process(delta : float):
	animated_sprite_2d.play('jump')


func on_physics_process(delta : float):
	if Input.is_action_pressed(character_body_2d.input_prefix + "move_right"):
		if character_body_2d.direction != 1:
			character_body_2d.scale.x *= -1
			character_body_2d.direction = 1
		character_body_2d.velocity.x = character_body_2d.running_speed
	if Input.is_action_pressed(character_body_2d.input_prefix + "move_left"):
		if character_body_2d.direction != -1:
			character_body_2d.scale.x *= -1
			character_body_2d.direction = -1
		character_body_2d.velocity.x = -character_body_2d.running_speed
	
	# Check for transitions to other states
	if Input.is_action_pressed(character_body_2d.input_prefix + "block"):
		state_machine.transition_to('block')
	if Input.is_action_just_pressed(character_body_2d.input_prefix + "attack_heavy"):
		state_machine.transition_to('flop')
	if Input.is_action_just_pressed(character_body_2d.input_prefix + "attack_light"):
		state_machine.transition_to('flyingsidekick')
	if character_body_2d.velocity.y > 0:
		state_machine.transition_to('fall')
	if character_body_2d.is_on_floor() and character_body_2d.velocity.y >= 0:
		state_machine.transition_to('idle')


func enter():
	character_body_2d.velocity.y = -character_body_2d.jump_velocity


func exit():
	pass
