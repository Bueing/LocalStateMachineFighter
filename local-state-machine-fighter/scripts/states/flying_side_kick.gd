extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine
@export var kick_velocity : int = 300

var damage_scene = load("res://scenes/damage.tscn")
var damage

var count : int = 0

func on_process(delta : float):
	animated_sprite_2d.play('flyingsidekick')


func on_physics_process(delta : float):
	count += 1
	
	# Check for transitions to other states
	if count >= 60: #Godot's physics gets calculated 60 times a second
		state_machine.transition_to('fall')
	if character_body_2d.is_on_floor():
		state_machine.transition_to('idle')
		


func enter():
	character_body_2d.velocity.x = kick_velocity * character_body_2d.direction
	count = 0
	damage = damage_scene.instantiate()
	damage.get_node('AnimatedSprite2D').play('white')
	damage.get_node('CollisionShape2DWide').disabled = true
	damage.position.x = 18
	damage.position.y = 6
	character_body_2d.add_child(damage)


func exit():
	if damage:
		damage.queue_free()
