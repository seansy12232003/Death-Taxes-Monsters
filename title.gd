extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	get_node("../Level1").stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_node("../Title").hide()
	get_node("../UI/AnimationPlayer").play("TransOut")
	if not get_node("../birds").is_playing():
		get_node("../birds").play()
	if not get_node("../Level1").is_playing():
		get_node("../Level1").play()
