extends Panel

var ItemName = ""
var ItemDes = ""
var ItemCost = 0
var ItemCount = 0
var hasItem = false
var mouseEntered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hasItem == true:
		get_node("Icon").show()
		get_node("Count").show()
		get_node("Count").text = str(ItemCount)
	else:
		get_node("Icon").hide()
		get_node("Count").hide()


func _on_mouse_entered() -> void:
	if hasItem == true:
		mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false

func _input(event):
	if event.is_action_pressed("LeftClick"):
		if mouseEntered:
			get_node("../../ItemInfo/Icon").texture = get_node("Icon").texture
			get_node("../../ItemInfo").ItemName = ItemName
			get_node("../../ItemInfo").ItemDes = ItemDes
			get_node("../../ItemInfo").ItemCost = ItemCost
			get_node("../../ItemInfo").ItemCount = ItemCount
			get_node("../../ItemInfo/AnimationPlayer").play("TransIn")
			get_node("../../ItemInfo").updateInfo()
			get_node("../../").process_mode = Node.PROCESS_MODE_DISABLED
