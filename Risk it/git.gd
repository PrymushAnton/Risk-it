extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not $Bg.playing:
		$Bg.play()
		

func _on_button_pressed():
	get_tree().change_scene_to_file("res://level_guide/level_guide.tscn")
	


func _on_button_2_pressed():
	get_tree().quit()


