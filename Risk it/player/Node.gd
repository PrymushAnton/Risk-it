extends Node

@onready var stats_menu = $"../Control"

@onready var pause_menu = $"../Pause2"

var stats: bool = false

var pause: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if stats == true:
		get_tree().paused = true
		stats_menu.show()
	else:
		get_tree().paused = false
		stats_menu.hide()
		
	if pause == true:
		get_tree().paused = true
		pause_menu.show()
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
