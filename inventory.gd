extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.offset.y = -500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_button_pressed() -> void:
	get_node("AnimationPlayer").play("TransOut")

func _input(event):
	if event.is_action_pressed("Inv"):
		if self.offset.y == -500:
			get_node("AnimationPlayer").play("TransIn")
		elif self.offset.y == 1000:
			get_node("AnimationPlayer").play("TransIn")
		elif self.offset.y == 150:
			get_node("AnimationPlayer").play("TransOut")
		get_node("InvContainer").fillInventorySlots()
