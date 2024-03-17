extends Area2D

@export var speed = 500

var movement_vector = Vector2(1, 0)
var player
var enemy
var initial_direction = 1
var direction: int = 0

func _ready():
	player = get_node("/root/Node2D/CharacterBody2D")
	enemy = get_node("/root/Node2D/Enemy")
	initial_direction = sign(player.position.x - enemy.position.x)

func _physics_process(delta):
	if initial_direction == -1:
		$TextureRect.flip_h = true
	elif initial_direction == 1:
		$TextureRect.flip_h = false
	var movement_vector = Vector2(initial_direction, 0)
	position += movement_vector * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.get_parent().is_in_group("Player") and area.name == "Hitbox":
		player.current_hp -= 5
		queue_free()
