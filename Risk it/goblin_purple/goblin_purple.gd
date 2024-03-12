extends CharacterBody2D

@export var strenght: int
@export var health: int
@export var speed: int
@export var X: int
@export var Y: int
@export var jump_velocity: int
@export var is_rotated: bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_player
var player
var can_move = true
#var player_is_alive = true
var attacking = false
var is_hitted = false
var can_attack = false
var can_follow = false
var is_dead = false

func _ready():
	animation_player = get_node('AnimationPlayer')
	player = get_node('/root/Node2D/CharacterBody2D')
	position.y = Y
	position.x = X
	if is_rotated:
		$AnimatedSprite2D.flip_h = true
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
		$DetectionArea.scale.x = abs($DetectionArea.scale.x) * -1
		$EyeSightArea.scale.x = abs($DetectionArea.scale.x) * -1

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
		
	
	
func end_of_hit_of_enemy():
	if can_attack:
		var overlapping_objects = $AttackArea.get_overlapping_areas()
		var is_flipped = $AnimatedSprite2D.flip_h
		for area in overlapping_objects:
			if area.get_parent().is_in_group('Player') and area.name != "AttackArea":
				area.get_parent().hit(strenght, area.get_parent(), is_flipped)
		$AttackArea/TimerAttack.start()
		can_attack = false

func death():
	queue_free()
	player.kill_count += 1


func _physics_process(delta):

	if player and not attacking and can_follow and not is_dead:
		var direction_vector = Vector2(player.position.x - position.x, 0).normalized()

		
		if direction_vector[0] > 0:
			$AnimatedSprite2D.flip_h = false
			$AttackArea.scale.x = abs($AttackArea.scale.x)
			$DetectionArea.scale.x = abs($DetectionArea.scale.x)
			$EyeSightArea.scale.x = abs($DetectionArea.scale.x)
		elif direction_vector[0] < 0:
			$AnimatedSprite2D.flip_h = true
			$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
			$DetectionArea.scale.x = abs($DetectionArea.scale.x) * -1
			$EyeSightArea.scale.x = abs($DetectionArea.scale.x) * -1
		
		if can_move and not is_hitted:
			velocity = direction_vector * speed
			animation_player.play('run')
			move_and_slide()

	if not is_on_floor() and not is_dead:
		can_move = false
		velocity.y += gravity * delta
		move_and_slide()
		
	if is_on_floor() and not is_dead:
		can_move = true
	
	if is_hitted and not is_dead:
		animation_player.play("hit")
		move_and_slide()
	
	if attacking and can_attack and not is_dead and not player.is_dead:
		animation_player.play("attack")
		
	if not can_follow and not is_dead:
		animation_player.play("idle")
		
	if player.is_dead:
		animation_player.play("idle")
	
	if is_dead:
		animation_player.play("death")

func _on_timer_timeout():
	is_hitted = false

func _on_detection_area_area_entered(area):
	if area.get_parent().is_in_group("Player") and area.name != "AttackArea":
		attacking = true

func _on_detection_area_area_exited(area):
	if area.get_parent().is_in_group("Player") and area.name != "AttackArea":
		attacking = false

func _on_timer_attack_timeout():
	can_attack = true

func _on_eye_sight_area_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		can_follow = true
		can_attack = true
		
