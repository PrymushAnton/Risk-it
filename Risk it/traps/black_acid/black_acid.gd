extends Node2D

var animation_player
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node('AnimationPlayer')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_player.play('idle')


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Player") and area.name != 'AttackArea':
		get_tree().change_scene_to_file("res://git.tscn")
