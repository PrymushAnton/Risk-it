extends RigidBody2D

@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var start_x: int = 0
@export var end_x: int = 0
@export var speed: float = 0
@export var is_rotated: bool


var bullet = preload("res://purple_goblin/bullet.tscn")
var direction: int = 0
var run = true
var player


func _ready():
	player = get_node("/root/Node2D/CharacterBody2D")
	if is_rotated:
		animated_sprite.flip_h = true
		$Area2D.scale.x = abs($Area2D.scale.x) * -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#linear_velocity.y += GRAVITY * speed
	if run == true:
		if position.x >= end_x:
			direction = -1
			animated_sprite.flip_h = true
			$Area2D.scale.x = abs($Area2D.scale.x) * -1
		elif position.x <= start_x:
			direction = 1
			animated_sprite.flip_h = false
			$Area2D.scale.x = abs($Area2D.scale.x)
		linear_velocity.x = direction * speed
		animation.play('Run')
		move_and_collide(linear_velocity)
	elif run == false:
		if player.global_position.x > position.x:
			$Area2D.scale.x = abs($Area2D.scale.x)
			animated_sprite.flip_h = false
		elif player.global_position.x < position.x:
			animated_sprite.flip_h = true
			$Area2D.scale.x = abs($Area2D.scale.x) * -1
		var direction_vector = Vector2(player.global_position.x - position.x, 0) 
		linear_velocity = direction_vector * speed
		animation.play('Run')

func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var bullet_shoot = bullet.instantiate()
		bullet_shoot.position = position
		get_tree().current_scene.add_child(bullet_shoot)
		run = false 

