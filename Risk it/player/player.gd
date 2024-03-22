extends CharacterBody2D

var pause_menu

var strenght = 50

var agility = 10

var endurance = 1234123131
var current_hp

var experience: int

var coins: int

var lable
var lable_text
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var end_of_first = false
var jumping = false
var can_move = true
var can_end_jump = false
var kill_count = 0

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
	current_hp = endurance
	#pause_menu = get_node("Pause_panel")
	
	#lable = get_node("Control/Strenght")
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
	
func hit_by_bullet(damage):
	velocity.x = move_toward(velocity.x, 0, SPEED)
	current_hp -= damage
	is_hitted = true
	attacking = false
	can_move = false
	jumping = false
	$Hitbox/Timer_bullet.start()
	if current_hp <= 0:
		is_dead = true
		

	

func hit(damage, player_func, flipped):

	current_hp -= damage
	#losing_hp.emit()
	is_hitted = true
	attacking = false
	can_move = false
	jumping = false
	$Hitbox/Timer.start()
	
	if not flipped:
		player_func.velocity = Vector2(200, 0)
	if flipped:
		player_func.velocity = Vector2(-200, 0)
	if current_hp <= 0:
		is_dead = true
		
func death():
	Input.action_release("attack")
	Input.action_release("ui_right")
	Input.action_release("ui_left")
	get_tree().change_scene_to_file('res://death_scene.tscn')
	
func end_of_jump():
	can_end_jump = true

func end_of_hit():
	if not is_hitted:
		var overlapping_objects = $AttackArea.get_overlapping_areas()
		var is_flipped = $AnimatedSprite2D.flip_h
		for area in overlapping_objects:
			if area.get_parent().is_in_group("Enemy") and area.name != 'AttackArea' and area.name != 'DetectionArea' and area.name != 'EyeSightArea' and area.name == "Hitbox":
				area.get_parent().hit_of_enemy(strenght, area, is_flipped)
		attacking = false
		can_attack = false
		can_move = true
		$AttackArea/AttackTimer.start()

func _physics_process(delta):
	
	if current_hp <= 0:
		is_dead = true
	
	if end_of_first:
		get_tree().change_scene_to_file("res://shop.tscn")
	
	if can_end_jump:
		if is_on_floor():
			jumping = false
	
	if is_dead:
		$CollisionShape2D.set_deferred('disabled', true)
		animation_player.play("death")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == 1 and not is_dead and not is_hitted and not attacking:
		$AnimatedSprite2D.flip_h = false
		$AttackArea.scale.x = abs($AttackArea.scale.x)
		
	elif direction == -1 and not is_dead and not is_hitted and not attacking:
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
	
	if jumping and is_on_floor() and not attacking and not is_hitted and not is_dead:
		velocity.y = JUMP_VELOCITY
		animation_player.play('jump')
	
	if is_hitted and not is_dead:
		animation_player.play("hit")
		move_and_slide()
		
	if attacking:
		animation_player.play('attack')
	
	if not is_dead and can_move:
		move_and_slide()
	#if pause:
		#get_tree().paused = true
		#pause_menu.show()
	#elif not pause:
		#get_tree().paused = false
		#pause_menu.hide()
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
	
func _on_timer_timeout():
	is_hitted = false
	can_move = true
	
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


func _on_jump_pressed():
	jumping = true
	can_end_jump = false


func _on_left_pressed():
	Input.action_press("ui_left")
func _on_left_released():
	Input.action_release("ui_left")



func _on_right_pressed():
	Input.action_press("ui_right")
func _on_right_released():
	Input.action_release("ui_right")


func _on_timer_bullet_timeout():
	is_hitted = false
	can_move = true


func _on_shop_pressed():
	$Shop.scale = Vector2(0.6, 0.6)


func _on_attack_pressed():
	if can_attack and not jumping and not is_dead and not is_hitted:
		can_move = false
		attacking = true


