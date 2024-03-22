extends Node

var pause_menu
var pause_button

var stats: bool = false

var pause: bool = false

func _ready():
	pause_menu = $"../Pause2"
	pause_button = $"../Pause"

func _process(delta):
	if pause == true:
		get_tree().paused = true
		pause_menu.show()
	elif pause == false:
		get_tree().paused = false
		pause_menu.hide()

func _on_pause_pressed():
	pause_button.modulate = Color(0.8, 0.8, 0.8, 1.0)
	pause = true
	
func _on_resume_pressed():
	pause_button.modulate = Color(1, 1, 1, 1)
	pause = false
