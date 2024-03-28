extends CharacterBody2D

@export var start_x: int
@export var end_x: int
@export var is_flipped: bool

@onready var bullet = load("res://fireball/fireball.tscn")
@onready var fire_cooldown = get_node("Timer")
@onready var animation_player = get_node("AnimationPlayer")
var player

var speed = 200.0
var jump_velocity = -400.0


var can_shoot = false
var attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
	#position.x = start_x


func shoot():

	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.global_rotation = get_angle_to(player.position)
	b.find_velocity()
	fire_cooldown.start()
	attacking = false
	

func _physics_process(delta):
	if can_shoot and not player.is_dead:
		if fire_cooldown.is_stopped():
			if position.x >= player.position.x:
				is_flipped = true
				$AnimatedSprite2D.flip_h = true
				attacking = true
				animation_player.play("attack")
			elif position.x <= player.position.x:
				is_flipped = false
				$AnimatedSprite2D.flip_h = false
				attacking = true
				animation_player.play("attack")
		
	if position.x <= start_x and is_flipped and not attacking:
		is_flipped = false
	if position.x >= end_x and not is_flipped and not attacking:
		is_flipped = true
		
	if is_flipped and not attacking:
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = true
	elif not is_flipped and not attacking:
		velocity.x = speed
		$AnimatedSprite2D.flip_h = false
		
	if not attacking:
		animation_player.play("run")
		move_and_slide()


func _on_eye_sight_area_area_entered(area):
	if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		player = area.get_parent()
		can_shoot = true
	

func _on_eye_sight_area_area_exited(area):
	if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		can_shoot = false
		

#func _on_timer_timeout():
	#can_detect = true
