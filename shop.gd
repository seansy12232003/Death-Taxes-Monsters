extends CanvasLayer

var currItem = 0
var select = 0 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Name.text = Global.items[currItem]["Name"]
	%Description.text = Global.items[currItem]["Description"] + "\nCost: " + str(Global.items[currItem]["Cost"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switchItem(select):
	for i in range(Global.items.size()):
		if select == i:
			currItem=select
			get_node("Control/item").texture = Global.items[currItem]["Icon"]
			get_node("Control/Name").text = Global.items[currItem]["Name"]
			get_node("Control/Description").text = Global.items[currItem]["Description"]
			get_node("Control/Description").text += "\nCost: " + str(Global.items[currItem]["Cost"])

func _on_button_pressed() -> void:
	get_node("AnimationPlayer").play("TransOut")
	get_tree().paused=false


func _on_next_pressed() -> void:
	switchItem(currItem+1)


func _on_prev_pressed() -> void:
	switchItem(currItem-1)

func _on_buy_pressed() -> void:
	var hasItem = false
	if Global.gold > Global.items[currItem]["Cost"]:
		for i in Global.inventory:
			if Global.inventory[i]["Name"] == Global.items[currItem]["Name"]:
				Global.inventory[i]["Count"]+=1
				hasItem=true
		if hasItem==false:
			var tempDic = Global.items[currItem]
			tempDic["Count"] = 1
			Global.inventory[Global.inventory.size()] = tempDic
		Global.gold-=Global.items[currItem]["Cost"]
	print(Global.inventory)
		
		
