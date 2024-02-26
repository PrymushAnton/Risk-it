extends Node2D

var animation_player

func _ready():
	animation_player = get_node("Area2D/AnimationPlayer")
	
func _physics_process(delta):
	animation_player.play("spike")
	
func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		print("1")
