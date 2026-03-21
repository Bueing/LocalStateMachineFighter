extends State

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : FiniteStateMachine

var damage_scene = load("res://scenes/damage.tscn")
var damage

var animation_finished : bool = false

func on_process(delta : float):
	animated_sprite_2d.play('punch')


func on_physics_process(delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, character_body_2d.slow_down_speed * delta / 2)
	if damage and damage.position.x >= 20:
		damage.queue_free()
	# Check for transitions to other states
	if animation_finished:
		state_machine.transition_to('idle')


func enter():
	animation_finished = false
	damage = damage_scene.instantiate()
	damage.owner_character = character_body_2d
	damage.get_node('AnimatedSprite2D').play('white')
	damage.get_node('CollisionShape2DWide').disabled = true
	damage.position.x = -10
	damage.position.y = -4
	character_body_2d.add_child(damage)
	damage.velocity.x = 100


func exit():
	if damage:
		damage.queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	animation_finished = true
