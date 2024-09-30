extends CharacterBody2D


const SPEED = 150.0


func _physics_process(delta):
	velocity = Vector2.ZERO # The player's movement vector
	if Input.is_action_pressed("ui_up",true) or Input.is_action_pressed("move_up",true):
		$AnimatedSprite2D.play("up")
		velocity.y = -SPEED
	if Input.is_action_pressed("ui_down",true) or Input.is_action_pressed("move_down",true):
		$AnimatedSprite2D.play("down")
		velocity.y = SPEED
	if Input.is_action_pressed("ui_left",true) or Input.is_action_pressed("move_left",true):
		$AnimatedSprite2D.play("left")
		velocity.x = -SPEED
	if Input.is_action_pressed("ui_right",true) or Input.is_action_pressed("move_right",true):
		$AnimatedSprite2D.play("right")
		velocity.x = SPEED
	if velocity.length() > 0:
		move_and_slide()
	else:
		$AnimatedSprite2D.stop()
