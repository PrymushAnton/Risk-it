extends Node2D

var animation_player
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node("AcidA/AnimationPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_player.play("Acid")


func _on_acid_a_body_entered(body):
	if body.name == "CharacterBody2D":
		print("1")
