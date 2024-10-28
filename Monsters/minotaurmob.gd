extends CharacterBody2D

signal battle_triggered

#@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D2
@export var speed = 10
var direction = Vector2.ZERO
var previous_position: Vector2

func _ready():
	previous_position = get_parent().position
	#$Area2D.connect("body_entered", self, "_on_body_entered")
	#


#const SPEED = 300.
#const JUMP_VELOCITY = -400.0
#
#
func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed *delta)
	#position = get_parent().position
	var direction = (get_parent().position - previous_position).normalized()
	if direction != Vector2.ZERO:
		play_walk_animation(direction)

	previous_position = get_parent().position
	#direction = Vector2.ZERO
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

 
func play_walk_animation(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):  # Moving horizontally
		if dir.x > 0:
			$AnimatedSprite2D.animation = "walk_right"
		else:
			$AnimatedSprite2D.animation = "walk_left"
	else:  # Moving vertically
		if dir.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
		else:
			$AnimatedSprite2D.animation = "walk_up"
	
	# Ensure the animation is playing
	$AnimatedSprite2D.play()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		emit_signal("battle_triggered")
		print("Battle Triggered")

 
