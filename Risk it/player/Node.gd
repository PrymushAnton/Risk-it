extends Node

@onready var pause_menu = $"../Control"

var pause: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if pause == true:
		get_tree().paused = true
		pause_menu.show()
	else:
		get_tree().paused = false
		pause_menu.hide()

func _on_pause_pressed():
	pause = !pause

func _on_close_pressed():
	pause = !pause
