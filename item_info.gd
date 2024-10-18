extends CanvasLayer
var ItemName = ""
var ItemDes = ""
var ItemCost = 0
var ItemCount = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateInfo():
	get_node("Name").text = ItemName
	get_node("Des").text = ItemDes + "\nCost: " + str(ItemCost)
	
func _on_button_pressed() -> void:
	get_node("AnimationPlayer").play("TransOut")
	get_node("../").process_mode = Node.PROCESS_MODE_ALWAYS


func _on_button_2_pressed() -> void:
	for i in Global.inventory:
		if Global.inventory[i]["Name"] == ItemName:
			ItemCount-=1
			if ItemCount == 0:
				#remove item from inventory,then update inventory
				var tempDic = {}
				for x in Global.inventory:
					if x>i:
						tempDic[x-1] = Global.inventory[x]
					elif x<i:
						tempDic[x] = Global.inventory[x]
				Global.inventory.clear()
				Global.inventory = tempDic
				_on_button_pressed()
			else:
				Global.inventory[i]["Count"]-=1
			get_node("../InvContainer").fillInventorySlots()
