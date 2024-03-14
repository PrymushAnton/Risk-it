extends Node2D

@onready var sword1 = $TextureRect2
@onready var sword2 = $TextureRect3
@onready var ring1 = $TextureRect4
@onready var armor1 = $TextureRect5
@onready var armor2 = $TextureRect6
@onready var armor3 = $TextureRect7

@onready var bought1 = $Label
@onready var bought2 = $Label2
@onready var bought3 = $Label3
@onready var bought4 = $Label4
@onready var bought5 = $Label5
@onready var bought6 = $Label6

func buy(item, label):
	item.hide()
	label.show()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	buy(sword1,bought1) # Replace with function body.


func _on_button_2_pressed():
	buy(sword2,bought2) # Replace with function body.


func _on_button_3_pressed():
	buy(ring1,bought3) # Replace with function body.


func _on_button_4_pressed():
	buy(armor1,bought4) # Replace with function body.


func _on_button_5_pressed():
	buy(armor2,bought5) # Replace with function body.


func _on_button_6_pressed():
	buy(armor3,bought6) # Replace with function body.
