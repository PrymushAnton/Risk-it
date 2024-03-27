extends RigidBody2D

var player
var animation_player
var hitted_player = false

func _ready():
	$Launched.play()
	add_to_group("Bullet")
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_node("AnimationPlayer")

func find_velocity():
	if player:
		linear_velocity = global_position.direction_to(player.position) * 8
		
		


func _process(delta):
	
	if player:
		animation_player.play("idle")
		move_and_collide(linear_velocity)


func _on_area_2d_body_entered(body):
	if body.name == 'TileMap':
		queue_free()
	if body.is_in_group("Player"):
		body.hit_by_bullet(7)
		queue_free()
		
	if body.is_in_group("Enemy"):
		queue_free()
	#if body.get_parent().is_in_group("Player"):
		#hitted_player = true
