extends CharacterBody2D

var screensize
const ORIGINAL_SPEED = 75.0
var SPEED = 75.0

func _ready():
	#screensize = get_viewport_rect().size
	if get_parent().name != "Player": # call spawn animation if in battle scene
		hide()

func _physics_process(delta):
	if get_parent().name != "Player":
		velocity = Vector2.ZERO # The player's movement vector
		if Input.is_action_pressed("ui_up",true) or Input.is_action_pressed("move_up",true):
			$AnimatedSprite2D.play("up")
			velocity.y = -SPEED
		elif Input.is_action_pressed("ui_down",true) or Input.is_action_pressed("move_down",true):
			$AnimatedSprite2D.play("down")
			velocity.y = SPEED
		elif Input.is_action_pressed("ui_left",true) or Input.is_action_pressed("move_left",true):
			$AnimatedSprite2D.play("left")
			velocity.x = -SPEED
		elif Input.is_action_pressed("ui_right",true) or Input.is_action_pressed("move_right",true):
			$AnimatedSprite2D.play("right")
			velocity.x = SPEED
		if velocity.length() > 0:
			move_and_slide()
		else:
			$AnimatedSprite2D.stop()
	
	# prevent player from going outside the screen
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)

func set_pos(pos): # function to set position of player
	position = pos
	show()
	$CollisionShape2D.disabled = false

func set_speed(new_speed):
	SPEED = new_speed

func reset_speed():
	SPEED = ORIGINAL_SPEED
