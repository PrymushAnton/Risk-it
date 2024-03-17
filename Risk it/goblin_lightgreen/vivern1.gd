extends CharacterBody2D

@export var start_x: int
@export var end_x: int
@export var is_flipped: bool

@onready var bullet = load("res://goblin_lightgreen/fireball.tscn")
@onready var fire_cooldown = get_node("Timer")
var player

var speed = 200.0
var jump_velocity = -400.0

var can_shoot = false
var can_detect = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func shoot():

	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.global_rotation = get_angle_to(player.position)
	b.find_velocity()
	
	can_detect = false
	fire_cooldown.start()

func _physics_process(delta):
		
	if can_shoot and not player.is_dead:
		if fire_cooldown.is_stopped():
			shoot()
		
	if position.x <= start_x and is_flipped:
		is_flipped = false
	if position.x >= end_x and not is_flipped:
		is_flipped = true
		
	if is_flipped:
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = true
	elif not is_flipped:
		velocity.x = speed
		$AnimatedSprite2D.flip_h = false

	move_and_slide()


func _on_eye_sight_area_area_entered(area):
	if area.get_parent().is_in_group("Player") and can_detect and area.name == "Hitbox":
		player = area.get_parent()
		can_shoot = true
	

func _on_eye_sight_area_area_exited(area):
	if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		can_shoot = false
		

func _on_timer_timeout():
	can_detect = true
