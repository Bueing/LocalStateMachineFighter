extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine
@export var collision_shape: CollisionShape2D

var damage_scene = load("res://scenes/damage.tscn")
var damage

func on_process(delta : float):
	animated_sprite_2d.play('flop')


func on_physics_process(delta : float):
	
	# Check for transitions to other states
	if not(Input.is_action_pressed(character_body_2d.input_prefix + "attack_heavy")):
		state_machine.transition_to('fall')
	if character_body_2d.is_on_floor():
		state_machine.transition_to('idle')


func enter():
	collision_shape.rotate(PI/2)
	damage = damage_scene.instantiate()
	damage.get_node('AnimatedSprite2D').play('redwide')
	damage.get_node('CollisionShape2D').disabled = true
	damage.position.y = 4
	character_body_2d.add_child(damage)


func exit():
	collision_shape.rotate(-PI/2)
	if damage:
		damage.queue_free()
