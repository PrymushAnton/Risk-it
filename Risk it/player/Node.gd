extends Node

var pause_menu
var pause_button

var stats: bool = false

var pause: bool = false

func _ready():
	pause_menu = $"../Pause2"
	pause_button = $"../Pause"

#func _process(delta):
#
	#if pause:
		#get_tree().paused = true
		#pause_menu.show()
	#elif not pause:
		#get_tree().paused = false
		#pause_menu.hide()

#func _on_pause_pressed():
	#pause = true
	##pause_button.modulate = Color(0.8, 0.8, 0.8, 1.0)
	##pause_menu.show()
	#
#func _on_resume_pressed():
	#pass
	##pause_button.modulate = Color(1, 1, 1, 1)
	##pause_menu.hide()
#
#
#func _on_resume_2_pressed():
	##pause_menu.hide()
	#pause = false

