extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not $Bg.playing:
		$Bg.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://git.tscn")



