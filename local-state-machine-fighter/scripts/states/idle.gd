extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine

func on_process(delta : float):
	animated_sprite_2d.play('idle')


func on_physics_process(delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, character_body_2d.slow_down_speed * delta / 2)
	
	# Check for transitions to other states
	if Input.is_action_pressed(character_body_2d.input_prefix + "block"):
		state_machine.transition_to('block')
	if Input.is_action_just_pressed(character_body_2d.input_prefix + "attack_heavy"):
		state_machine.transition_to('kick')
	if Input.is_action_just_pressed(character_body_2d.input_prefix + "attack_light"):
		state_machine.transition_to('punch')
	if Input.is_action_just_pressed(character_body_2d.input_prefix + "jump"):
		state_machine.transition_to('jump')
	if Input.is_action_pressed(character_body_2d.input_prefix + "move_right") or Input.is_action_pressed(character_body_2d.input_prefix + "move_left"):
		state_machine.transition_to('run')
		
	
	


func enter():
	pass


func exit():
	pass
