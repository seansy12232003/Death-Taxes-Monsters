extends CharacterBody2D

@export var speed = 10
var direction = Vector2.ZERO
var previous_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_position = get_parent().position

func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed *delta)
	#position = get_parent().position
	var direction = (get_parent().position - previous_position).normalized()
	if direction != Vector2.ZERO:
		play_walk_animation(direction)

	previous_position = get_parent().position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	get_node("../../../Dialogue/DialogueBox/Panel/Label").text = ""
	get_node("../../../Dialogue/DialogueBox").show()
	$Timer.start()
	get_tree().paused = true
	$Timer2.start()



func _on_timer_timeout() -> void:
	get_node("../../../Dialogue/DialogueBox/Panel/Label").text = "Beware of Monsters in the forest!"
	#$Bark.play()
	$Timer.stop()


func _on_timer_2_timeout() -> void:
	get_tree().paused = false
	get_node("../../../Dialogue/DialogueBox").hide()
	#$Bark.stop()
	$Timer2.stop()
