extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var speed = 400

var bullet = preload("res://purple_goblin_character/bullet.tscn")
var direction: int = 0
var run = true
var player
const JUMP_VELOCITY = -400.0
var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Node2D/CharacterBody2D")
	enemy = get_node("/root/Node2D/Enemy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run == true:
		#if position.x >= end_x:
			#direction = -1
			#animated_sprite.flip_h = true
		#elif position.x <= start_x:
			#direction = 1
			#animated_sprite.flip_h = false
		#velocity.x = direction * speed
		animation.play('Idle')
		#move_and_collide(velocity)
	elif run == false:
		if player.global_position > global_position:
			animated_sprite.flip_h = false
		elif player.global_position < global_position:
			animated_sprite.flip_h = true
		#var direction_vector = Vector2(player.global_position.x - global_position.x, 0).normalized()
		#velocity = direction_vector * SPEED
		var direction_to_player = (player.global_position - global_position).normalized()
		var direction_vector = Vector2(direction_to_player.x, 0)
		velocity = direction_vector * speed
		print(velocity)
		animation.play('Run')

func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var bullet_shoot = bullet.instantiate()
		bullet_shoot.position = position
		get_tree().current_scene.add_child(bullet_shoot)
		#get_tree().set_deferred("current_scene.add_child", bullet_shoot)
		run = false 
