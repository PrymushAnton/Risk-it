extends CanvasLayer



func _on_грати_pressed() -> void:
	get_tree().change_scene_to_file("res://level_forest/level_forest.tscn")


func _on_вийти_pressed() -> void:
	get_tree().quit()
