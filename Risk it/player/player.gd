extends CharacterBody2D

var strenght = 20

var agility = 10

var endurance = 10

var health = 5010240104

var lable
var lable_text
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var kill_count = 0

var experience: int

var coins: int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player
var player
var is_hitted = false
#var can_release = false
var attacking = false
var is_dead = false
var can_attack = true

func _ready():
	animation_player = get_node("AnimationPlayer") 
	player = get_node('.')
	#
	#lable = get_node("Pause2/Strenght")
	#lable_text = lable.get_text()
	#$Pause2/Strenght.set_text(str($Pause2/Strenght.get_text()) + " " + str(strenght))
	#$Pause2/Endurance.set_text(str($Pause2/Endurance.get_text()) + " " + str(endurance))
	#$Pause2/Agility.set_text(str($Pause2/Agility.get_text()) + " " + str(agility))
	if experience == 0:
		$Pause2/Upgrade_strenght.disabled = true
		$Pause2/Upgrade_agility.disabled = true
		$Pause2/Upgrade_endurance.disabled = true
	
func hit(damage, player_func, flipped):
	health -= damage
	$Hitbox/Timer.start()
	is_hitted = true
	attacking = false
	
	if not flipped:
		player_func.velocity = Vector2(200, 0)
	if flipped:
		player_func.velocity = Vector2(-200, 0)
	if health <= 0:
		is_dead = true
		
func death():
	get_tree().change_scene_to_file("res://git.tscn")

func end_of_hit():
	if not is_hitted:
		var overlapping_objects = $AttackArea.get_overlapping_areas()
		var is_flipped = $AnimatedSprite2D.flip_h
		for area in overlapping_objects:
			if area.get_parent().is_in_group("Enemy") and area.name != 'AttackArea' and area.name != 'DetectionArea' and area.name != 'EyeSightArea' and area.name == "Hitbox":
				area.get_parent().hit_of_enemy(strenght, area, is_flipped)
		attacking = false
		can_attack = false
		$AttackArea/AttackTimer.start()

func _physics_process(delta):
	if kill_count == 17:
		get_tree().change_scene_to_file('res://shop.tscn')
	
	if is_dead:
		animation_player.play("death")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		$AttackArea.scale.x = abs($AttackArea.scale.x)
		
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
		
	if direction:
		if not attacking and not is_hitted and not is_dead:
			velocity.x = direction * SPEED
			if is_on_floor():
				animation_player.play('run')
	else:
		if not attacking and not is_hitted and not is_dead:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor():
				animation_player.play('idle')
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not attacking and not is_hitted and not is_dead:
		velocity.y = JUMP_VELOCITY
		animation_player.play('jump')
	
	if is_hitted and not is_dead:
		animation_player.play("hit")
		
	if Input.is_action_just_pressed("attack"):
		 #and can_attack
		if not direction and not attacking and not is_hitted and not is_dead and can_attack:
			attacking = true
			
	if attacking and not is_dead:
		animation_player.play('attack')
	
	if experience != 0:
		$Pause2/Experience_value.set_text(' ' + str(experience))
		$Pause2/Upgrade_strenght.disabled = false
		$Pause2/Upgrade_agility.disabled = false
		$Pause2/Upgrade_endurance.disabled = false
	
	if coins != 0:
		$Pause2/Coins_Value.set_text(' ' + str(coins))
		
	if experience == 0:
		$Pause2/Upgrade_strenght.disabled = true
		$Pause2/Upgrade_agility.disabled = true
		$Pause2/Upgrade_endurance.disabled = true
	
	if not is_dead:
		move_and_slide()
	
func _on_timer_timeout():
	is_hitted = false
	
func _on_attack_timer_timeout():
	can_attack = true

# ошибка в добавлении

func _on_upgrade_strenght_pressed():
	strenght += 1
	$Pause2/Strenght_value.set_text(str(strenght))
	experience -= 1
	$Pause2/Experience_value.set_text(' ' + str(experience))
	if experience == 0:
		$Pause2/Upgrade_strenght.disabled = true
		$Pause2/Upgrade_agility.disabled = true
		$Pause2/Upgrade_endurance.disabled = true

func _on_upgrade_agility_pressed():
	agility += 1
	$Pause2/Agility_value.set_text(str(agility))
	experience -= 1
	$Pause2/Experience_value.set_text(' ' + str(experience))
	if experience == 0:
		$Pause2/Upgrade_strenght.disabled = true
		$Pause2/Upgrade_agility.disabled = true
		$Pause2/Upgrade_endurance.disabled = true

func _on_upgrade_endurance_pressed():
	endurance += 1
	$Pause2/Endurance_value.set_text(str(endurance))
	experience -= 1
	$Pause2/Experience_value.set_text(' ' + str(experience))
	if experience == 0:
		$Pause2/Upgrade_strenght.disabled = true
		$Pause2/Upgrade_agility.disabled = true
		$Pause2/Upgrade_endurance.disabled = true

func _on_shop_pressed():
	$Shop.scale = Vector2(0.6, 0.6)
