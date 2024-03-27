extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not $Bg.playing:
		$Bg.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://level_guide/level_guide.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://git.tscn")
