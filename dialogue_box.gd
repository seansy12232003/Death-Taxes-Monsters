extends CanvasLayer
signal dialogue_finished
var dialogue_data = []  # Array of dictionaries, e.g., [{"speaker": "Player", "text": "Hello!"}, ...]
var current_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func start_dialogue(data):
	dialogue_data = data
	current_index = 0
	visible = true
	_show_current_line()

func _show_current_line():
	if current_index >= dialogue_data.size():
		_end_dialogue()
		return
	
	var line = dialogue_data[current_index]
	$HBoxContainer/PlayerPortrait.visible = line.speaker == "Player"
	$HBoxContainer/NPCPortrait.visible = line.speaker == "NPC"
	$VBoxContainer/DialogueLabel.text = line.text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
