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
	#await get_tree().create_timer(0.5).timeout
	#get_node("../textsound").play()
	#get_node("../Introduction/Label").text = "Here, taxes are not just a duty, they are survival.\nThe king's wrath falls like a hammer upon those who cannot pay."
	#await get_tree().create_timer(8).timeout
	#get_node("../Introduction/Label").text = "Your father, a humble farmer, had always managed to pay his dues.\nUntil one day, the wind blew away the documents he needed to prove his payment."
	#await get_tree().create_timer(9).timeout
	#get_node("../Introduction/Label").text = "The king, ruthless and unwavering, declared your father guilty.\nHe was taken to the castle, imprisoned until the documents are found."
	#await get_tree().create_timer(8).timeout
	#get_node("../Introduction/Label").text = "Now, you must find the scattered papers across the land and prove your father’s innocence.\nTime is short, and the journey ahead is treacherous."
	#await get_tree().create_timer(10).timeout
	#get_node("../Introduction/Label").text = "Will you find the documents and outwit the king?\nOr will you face him in battle to save your father?\nYour path is yours to choose.\nYour journey awaits."
	#await get_tree().create_timer(7).timeout
	get_node("../textsound").stop()
	get_node("../Introduction").hide()
	get_node("../UI/AnimationPlayer").play("TransOut")
	get_tree().paused = false
	if not get_node("../birds").is_playing():
		get_node("../birds").play()
	if not get_node("../Level1").is_playing():
		get_node("../Level1").play()
	
