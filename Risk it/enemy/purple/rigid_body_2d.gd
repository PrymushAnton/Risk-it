extends RigidBody2D

@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var start_x: int = 0
@export var end_x: int = 0
@export var speed: float = 0

var can_move = true

var direction: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = start_x
	#if position.x >= end_x or position.x <= start_x:
		#$Timer.start()
		#print($Timer.time_left)
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if position.x >= end_x:
		$Timer.start()
		print($Timer.time_left)
		if $Timer.time_left == 0:
			direction = -1
			animated_sprite.flip_h = true
		elif not $Timer.time_left == 0:
			animation.play('idle')
			can_move = false
	elif position.x <= start_x:
		$Timer.start()
		print($Timer.time_left)
		if $Timer.time_left == 0:
			direction = 1
			animated_sprite.flip_h = false
		elif not $Timer.time_left == 0:
			animation.play('idle')
			can_move = false
	if can_move:
		#print(42)
		linear_velocity.x = direction * speed
		animation.play('run')
	move_and_collide(linear_velocity)

func _on_timer_timeout():
	can_move = true
	print(111111111111111111)
	set_physics_process(true)
