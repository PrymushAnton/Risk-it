extends CharacterBody2D

var strenght = 10

var agility = 10

var endurance = 10
var health = 50
var lable
var lable_text
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player
var player
var is_hitted = false
var can_attack = true
var can_release = false
var attacking = false

func _ready():
	animation_player = get_node("AnimationPlayer") 
	player = get_node('.')
	
	lable = get_node("Control/Strenght")
	lable_text = lable.get_text()
	lable.set_text(str(lable_text) + " " + str(strenght))
	$Control/Endurance.set_text(str($Control/Endurance.get_text()) + " " + str(endurance))
	$Control/Agility.set_text(str($Control/Agility.get_text()) + " " + str(agility))


func hit(damage, enemy, flipped):
	health -= damage
	$Hitbox/Timer.start()
	is_hitted = true
	#can_attack = false
	
	if not flipped:
		enemy.velocity = Vector2(200, 0)
	if flipped:
		enemy.velocity = Vector2(-200, 0)
	if health <= 0:
		get_tree().change_scene_to_file('res://git.tscn')
		

func end_of_hit():
	if not is_hitted:
		var overlapping_objects = $AttackArea.get_overlapping_areas()
		var is_flipped = $AnimatedSprite2D.flip_h
		for area in overlapping_objects:
			if area.get_parent().is_in_group("Enemy") and area.name != 'AttackArea' and area.name != 'DetectionArea' and area.name != 'EyeSightArea':
				area.get_parent().hit_of_enemy(strenght, area, is_flipped)
		attacking = false
		#can_attack = false
		#$AttackArea/AttackTimerCooldown.start()
		
func _physics_process(delta):
	print(health)
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("attack"):
		
		if not direction and can_attack and not attacking and not is_hitted:
			attacking = true
			animation_player.play('attack')
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		$AttackArea.scale.x = abs($AttackArea.scale.x)
		
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
		
	if direction:
		if not attacking and not is_hitted:
			velocity.x = direction * SPEED
			if is_on_floor():
				animation_player.play('run')
	else:
		if not attacking and not is_hitted:
			 #and not is_hitted
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor():
				animation_player.play('idle')
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not attacking and not is_hitted:
		velocity.y = JUMP_VELOCITY
		animation_player.play('jump')
	
	#if is_hitted:
		#animation_player.play('idle')
	if health <= 0:
		get_tree().change_scene_to_file('res://git.tscn')
	move_and_slide()
	
func _on_timer_timeout():
	is_hitted = false
	#can_attack = true
	#attacking = false

func _on_attack_timer_cooldown_timeout():
	can_attack = true

func health_minus():
	health = health - 10
