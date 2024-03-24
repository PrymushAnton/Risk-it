extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node('AnimationPlayer')
@onready var animated_sprite: AnimatedSprite2D = get_node('AnimatedSprite2D')

@export var speed = 100
@export var is_rotated: bool
@export var strenght = 10
@export var health = 30

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullet = preload("res://archer_goblin/bullet.tscn")
var direction: int = 0

var can_run = false
var can_move
var can_run_first = false

var player
var raycast
const JUMP_VELOCITY = -400.0
var enemy
var can_shoot = false
var attack_cooldown = false
var is_hitted = false
var is_dead = false

var direction_vector


func hit_of_enemy(damage, enemy, flipped):
	is_hitted = true
	$Hitbox/Timer.start()
	health -= damage
	if not flipped:
		enemy.get_parent().velocity = Vector2(100, 0)
	if flipped:
		#$AnimatedSprite2D.flip_h = true
		enemy.get_parent().velocity = Vector2(-100, 0)
	if health <= 0:
		#enemy.get_parent().queue_free()
		is_dead = true
		$CollisionShape2D.set_deferred('disabled', true)

func death():
	queue_free()


func _ready():
	player = get_node("/root/Node2D/CharacterBody2D")
	#enemy = get_node("/root/Node2D/Enemy")
	raycast = get_node('RayCast2D')
	if is_rotated:
		animated_sprite.flip_h = true
		$Area2D.scale.x = abs($Area2D.scale.x) * -1
		$RayCast2D.scale.x = abs($RayCast2D.scale.x) * -1
	


func _physics_process(delta):
	#if raycast.is_colliding():
		#
		#print(raycast.get_collider().is_in_group("Player"))
	if raycast.is_colliding() and raycast.get_collider().is_in_group("Player") and not is_dead and not is_hitted:
		can_run = true
		can_run_first = true
	if not is_hitted:
		direction_vector = Vector2(player.position.x - position.x, 0).normalized()

	if direction_vector[0] > 0 and not is_dead and not is_hitted:
		if raycast.is_colliding() and raycast.get_collider().is_in_group("Player"):
			can_shoot = true
			can_move = false
		else:
			can_move = true

	elif direction_vector[0] < 0 and not is_dead and not is_hitted:
		
		if raycast.is_colliding() and raycast.get_collider().is_in_group("Player"):
			can_move = false
			can_shoot = true
		else:
			can_move = true
	
	if not is_on_floor() and not is_dead:
		can_run = false
		velocity.y += gravity * delta
		move_and_slide()
	if is_on_floor() and can_run_first and not can_shoot and not is_dead and not is_hitted:
		can_run = true
	if not can_run_first and not is_dead:
		animation.play('Idle')
	if can_run and can_move and not is_dead and not is_hitted:
		if direction_vector[0] > 0:
			$AnimatedSprite2D.flip_h = false
			$Area2D.scale.x = abs($Area2D.scale.x)
			$RayCast2D.scale.x = abs($RayCast2D.scale.x)

		elif direction_vector[0] < 0:
			$AnimatedSprite2D.flip_h = true
			$Area2D.scale.x = abs($Area2D.scale.x) * -1
			$RayCast2D.scale.x = abs($RayCast2D.scale.x) * -1

		#var direction_vector = Vector2(direction_to_player.x, 0)
		velocity = direction_vector * speed
		animation.play('Run')
		move_and_slide()
		#move_and_collide(velocity)
		
	if can_shoot and not attack_cooldown and not is_dead and not is_hitted:
		if raycast.is_colliding() and raycast.get_collider().is_in_group("Player"):
			can_run = false
			start_of_attack()
		else:
			can_run = true
			can_move = true
			break_of_attack()
	
	if not can_move and can_run and not is_hitted and not is_dead:
		animation.play("Idle")
		
	if is_dead:
		animation.play("Death")
		
	if not is_dead and is_hitted:
		animation.play("Hit")
		move_and_slide()
	#if raycast.is_colliding() and raycast.get_collider().is_in_group("Player"):
		
	

func end_of_attack():
	can_run = true
	can_shoot = false
	var bullet_shoot = bullet.instantiate()
	bullet_shoot.position = position
	get_tree().current_scene.add_child(bullet_shoot)
	$Attack_cooldown.start()
	attack_cooldown = true

func start_of_attack():
	animation.play("Attack")
	
func break_of_attack():
	animation.play('Run')

#func _on_area_2d_area_entered(area):
	#if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		##get_tree().set_deferred("current_scene.add_child", bullet_shoot)
		#can_run = true
		#can_run_first = true


#func _on_area_2d_area_exited(area):
	#if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		#get_tree().set_deferred("current_scene.add_child", bullet_shoot)



func _on_attack_cooldown_timeout():
	attack_cooldown = false



func _on_timer_timeout():
	is_hitted = false
