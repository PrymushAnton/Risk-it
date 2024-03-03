extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player
var switch
var go_to_player = false
func _ready():
	animation_player = get_node("AnimationPlayer")
	

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		switch = true
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		switch = false

	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and not Input.is_mouse_button_pressed(1):
			animation_player.play('run')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not Input.is_mouse_button_pressed(1):
			animation_player.play('idle')
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play('jump')
	
	if switch == false:
		$Area2D/CollisionShape2DRight.disabled = true
		if Input.is_mouse_button_pressed(1):
			$Area2D/CollisionShape2DLeft.disabled = false
			animation_player.play('attack')
		else:
			$Area2D/CollisionShape2DLeft.disabled = true
	else:
		$Area2D/CollisionShape2DLeft.disabled = true
		if Input.is_mouse_button_pressed(1):
			$Area2D/CollisionShape2DRight.disabled = false
			animation_player.play('attack')
		else:
			$Area2D/CollisionShape2DRight.disabled = true
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group('Hit'):
		#body.take_damage()
	#else:
		#pass # Replace with function body.
		body.a(body)
