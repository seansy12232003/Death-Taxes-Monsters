extends CharacterBody2D

@export var speed = 10
var direction = Vector2.ZERO
var previous_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_position = get_parent().position

func _physics_process(delta: float) -> void:
	#get_parent().set_progress(get_parent().get_progress() + speed *delta)
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
	if body.name == "Player":
		get_node("../Dialogue/DialogueBox/Panel/Label").text = ""
		get_node("../Dialogue/DialogueBox").show()
		if get_node("../BattleMusic").is_playing():
			get_node("../BattleMusic").stop()
		$Talk.play()
		get_tree().paused = true
		await get_tree().create_timer(0.8).timeout
		get_node("../Dialogue/DialogueBox/Panel/Label").text = "OMG SON YOU FOUND ME!"
		await get_tree().create_timer(3).timeout
		get_node("../Dialogue/DialogueBox/Panel/Label").text = "Did you find the missing tax documents?"
		await get_tree().create_timer(3).timeout
		if Global.documents == 6:
			get_node("../Dialogue/DialogueBox/Panel/Label").text = "You found all six tax documents! Let's go home."
			$Talk.stop()
			await get_tree().create_timer(3).timeout
			game_over()
		else: 
			get_node("../Dialogue/DialogueBox/Panel/Label").text = "No, you didn't. Fight the king to free me please!"
			await get_tree().create_timer(3).timeout
			get_node("../Dialogue/DialogueBox/Panel/Label").text = "Or go back and find them."
			$Talk.stop()
			$Timer2.start()



func _on_timer_timeout() -> void:
	get_node("../../../Dialogue/DialogueBox/Panel/Label").text = "Beware of Monsters in the forest!"
	$Talk.play()
	#$Bark.play()
	$Timer.stop()


func _on_timer_2_timeout() -> void:
	get_tree().paused = false
	get_node("../Dialogue/DialogueBox").hide()
	#$Bark.stop()
	$Timer2.stop()
	
func game_over() -> void:
	await get_tree().create_timer(3).timeout
	get_node("../GameOverScreen").show()
	get_node("../UI/AnimationPlayer").play("TransOut")
	get_node("../level3").stop()
	get_tree().paused = true
	get_node("../winmusic").play()
