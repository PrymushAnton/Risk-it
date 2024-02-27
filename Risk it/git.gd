extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	
	
func _process(delta):
	print($Timer.time_left)

func _on_timer_timeout():
	print(1)
