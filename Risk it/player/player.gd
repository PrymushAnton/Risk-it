extends CharacterBody2D

var strenght = 10

var agility = 10

var endurance = 10
var lable
var lable_text
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player



func _ready():
	animation_player = get_node("AnimationPlayer") 
	lable = get_node("Control/Panel/Strenght")
	lable_text = lable.get_text()
	lable.set_text(str(lable_text) + " " + str(strenght))
	$Control/Panel/Endurance.set_text(str($Control/Panel/Endurance.get_text()) + " " + str(endurance))
	$Control/Panel/Agility.set_text(str($Control/Panel/Agility.get_text()) + " " + str(agility))
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation_player.play('run')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation_player.play('idle')
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play('jump')

	move_and_slide()
