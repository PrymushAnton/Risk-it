extends RigidBody2D

@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var start_x: int = 0
@export var end_x: int = 0
@export var speed: float = 0

var direction: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = start_x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x >= end_x:
		direction = -1
		animated_sprite.flip_h = true
	elif position.x <= start_x:
		direction = 1
		animated_sprite.flip_h = false
	linear_velocity.x = direction * speed
	animation.play('run')
	move_and_collide(linear_velocity)
