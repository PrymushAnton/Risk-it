extends Node

@onready var stats_menu = $"../Control"

@onready var pause_menu = $"../Pause2"

var stats: bool = false

var pause: bool = false
var i: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(stats)
	if stats == true:
		if pause == false:
			get_tree().paused = true
			stats_menu.show()
	else:
		if pause == true:
			get_tree().paused = true
			stats_menu.hide()
		else:
			get_tree().paused = false
			stats_menu.hide()
		
	if pause == true:
		if stats == false:
			get_tree().paused = true
			pause_menu.show()
	else:
		if stats == true:
			get_tree().paused = true
			pause_menu.hide()
		else: 
			get_tree().paused = false
			pause_menu.hide()

		
		

	


func _on_pause_pressed():
	pause = !pause


func _on_close_pressed():
	stats = !stats


func _on_stats_pressed():
	stats = !stats # Replace with function body.


func _on_resume_pressed():
	pause = !pause # Replace with function body.
