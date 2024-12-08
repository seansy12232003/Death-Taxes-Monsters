extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	get_node("../Level1").stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_node("../Title").hide()
	get_node("../UI/AnimationPlayer").play("TransOut")
	get_node("../Introduction").show()
	await get_tree().create_timer(0.5).timeout
	get_node("../textsound").play()
	get_node("../Introduction/Label").text = "You wake up to find your house empty and your father nowhere to be seen."
	await get_tree().create_timer(7).timeout
	get_node("../Introduction/Label").text = "As you walk outside, a neighbor comes up to you."
	await get_tree().create_timer(5).timeout
	get_node("../Introduction/Label").text = "He tells you that your father just got arrested by the king for failing to pay his taxes."
	await get_tree().create_timer(8).timeout
	get_node("../Introduction/Label").text = "Now it is up to you to free your father by proving his innocence or rebelling against the King."
	await get_tree().create_timer(10).timeout
	get_node("../Introduction/Label").text = "There is a dangerous journey ahead. Be careful out there."
	await get_tree().create_timer(5).timeout
	get_node("../textsound").stop()
	get_node("../Introduction").hide()
	get_node("../UI/AnimationPlayer").play("TransOut")
	get_tree().paused = false
	if not get_node("../birds").is_playing():
		get_node("../birds").play()
	if not get_node("../Level1").is_playing():
		get_node("../Level1").play()
	
