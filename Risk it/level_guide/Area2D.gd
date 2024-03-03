extends Area2D

var number: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	var child_count: int = parent.get_child_count()
	for i in child_count:
		var children = parent.get_child(i)
		if children.is_in_group("Label_Coins"):
			number = children
		





func _on_body_entered(body):
	 
	if body.is_in_group("Players"):
		var coins = int(number.get_text())
		number.set_text(str(coins + 1))
		queue_free()
