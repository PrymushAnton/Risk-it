extends Area2D

@export var speed = 600

var movement_vector = Vector2(1, 0)
var player
var enemy
var initial_direction = 1
var direction: int = 0

func _ready():
	player = get_node("/root/Node2D/CharacterBody2D")
	$Timer.start()
	initial_direction = sign(player.position.x - position.x)

func _physics_process(delta):
	if initial_direction == -1:
		$TextureRect.flip_h = true
		$CollisionShape2D.scale.x = abs($CollisionShape2D.scale.x) * -1
	elif initial_direction == 1:
		$TextureRect.flip_h = false
		$CollisionShape2D.scale.x = abs($CollisionShape2D.scale.x)
	var movement_vector = Vector2(initial_direction, 0)
	position += movement_vector * speed * delta * 1.5

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		area.get_parent().hit_by_bullet(3)
		queue_free()





func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.name == 'TileMap':
		queue_free()
