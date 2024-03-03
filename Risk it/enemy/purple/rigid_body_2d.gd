extends RigidBody2D

#@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var start_x: int = 0
@export var end_x: int = 0
@export var speed: float = 0
var player
var direction: int = 0
var run = true
var switch
var animation
func _ready():
	position.x = start_x
	player = get_node("/root/Node2D/Player")
	animation = get_node('AnimationPlayer')


func _process(_delta):
	if run == true:
		if position.x >= end_x:
			direction = -1
			animated_sprite.flip_h = true
		elif position.x <= start_x:
			direction = 1
			animated_sprite.flip_h = false
		linear_velocity.x = direction * speed
		animation.play('run')
		move_and_collide(linear_velocity)
	elif run == false:
		if player.position.x > position.x:
			animated_sprite.flip_h = false
			switch = true
		elif player.position.x < position.x:
			animated_sprite.flip_h = true
			switch = false
		var direction_vector = Vector2(player.position.x - position.x, 0) 
		linear_velocity = direction_vector.normalized() * speed
		animation.play('run')
		
		if switch == false:
			$Area2D/CollisionShape2DRight.disabled = true
			if player: # нормальное условие придумать, и будет работать, если с анимацией всё ок будет
				print(222)
				$Area2D/CollisionShape2DLeft.disabled = false
				animation.play('Attack')
			else:
				$Area2D/CollisionShape2DLeft.disabled = true
		else:
			$Area2D/CollisionShape2DLeft.disabled = true
			if player: # нормальное условие придумать, и будет работать, если с анимацией всё ок будет
				print(333)
				$Area2D/CollisionShape2DRight.disabled = false
				animation.play('Attack')
			else:
				$Area2D/CollisionShape2DRight.disabled = true
		move_and_collide(linear_velocity)
		
#func take_damage():
	#animated_sprite.play('Dead')
	#var t = Timer.new()
	#t.set_wait_time(3)
	#t.set_one_shot(true)
	#self.add_child(t)
	#t.start()
	#await(t)#, "timeout")
	#animated_sprite.play('Dead')
	#t.set_wait_time(3)
	#t.set_one_shot(true)
	#self.add_child(t)
	#t.start()
	#await(t)
	#t.queue_free()
	#queue_free()

func a(body):
	run = false
