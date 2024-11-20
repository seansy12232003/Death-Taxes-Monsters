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
			$Bell.play()
			get_node("/root/World/Player/Inventory/InvContainer/Slot/Count").text = str(ItemCount)
			var random_int_range = randi() % 10
			if Global.inventory[i]["Name"] == "Health Potion":
				Game.selectedMonsters[0]["Health"] == 100
				$Bell.play()
				get_node("/root/World/Player/Inventory/InvContainer/Slot/Count").text = str(ItemCount)
			if Global.inventory[i]["Name"] == "Sword":
				Game.selectedMonsters[0]["Attacks"][0]["Damage"] += random_int_range
				print("Damage increased by " + str(random_int_range))
				$Bell.play()
				get_node("/root/World/Player/Inventory/InvContainer/Slot/Count").text = str(ItemCount)
			if Global.inventory[i]["Name"] == "Magic":
				Game.selectedMonsters[0]["Attacks"][2]["Damage"] += random_int_range
				print("Damage increased by " + str(random_int_range))
				$Bell.play()
				get_node("/root/World/Player/Inventory/InvContainer/Slot/Count").text = str(ItemCount)
			if Global.inventory[i]["Name"] == "Bow":
				Game.selectedMonsters[0]["Attacks"][1]["Damage"] += random_int_range
				print("Damage increased by " + str(random_int_range))
				$Bell.play()
				get_node("/root/World/Player/Inventory/InvContainer/Slot/Count").text = str(ItemCount)
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
