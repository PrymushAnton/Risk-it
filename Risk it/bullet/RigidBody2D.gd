extends RigidBody2D

@export var start_x: int = 0
@export var end_x: int = 0
@export var speed: float = 0
@export var direction: int = 1

func _ready():
	position.x = start_x

func _process(delta):
	linear_velocity.x = speed * direction
	move_and_collide(linear_velocity)
	if direction == 1 and position.x >= end_x:
		position.x = start_x
	elif direction == -1 and position.x <= end_x:
		position.x = start_x
