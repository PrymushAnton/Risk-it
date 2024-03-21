extends Node2D

func buy(item, label, button):
	item.hide()
	label.show()
	button.hide()
	
func _on_button_pressed():
	buy($TextureRect2,$Label, $Button) 

func _on_button_2_pressed():
	buy($TextureRect3,$Label2, $Button2) 

func _on_button_3_pressed():
	buy($TextureRect4,$Label3, $Button3) 

func _on_button_4_pressed():
	buy($TextureRect5,$Label4, $Button4) 

func _on_button_5_pressed():
	buy($TextureRect6,$Label5, $Button5) 

func _on_button_6_pressed():
	buy($TextureRect7,$Label6, $Button6)

func _on_menu_pressed():
	$".".scale = Vector2(0, 0)
