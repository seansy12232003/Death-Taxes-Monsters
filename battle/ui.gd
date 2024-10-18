extends Control


func _on_fight_pressed() -> void:
	$Menu.hide()
	$"Fight/GridContainer/Attack 1".grab_focus()
	$Fight.show()
	

func _on_back_pressed() -> void:
	$Menu.show()
	$Menu/GridContainer/Fight.grab_focus()
	$Fight.hide()
	$Items.hide()
	

func _process(delta):
	
	# SET PLAYER INFO
	$"../BattleUI/HPBar".value = Game.selectedMonsters[0]["Health"]
	$"../BattleUI/Info".text = str(Game.selectedMonsters[0]["Name"]) + " LVL" + str(Game.selectedMonsters[0]["Level"])
	$"../BattleUI/HpTxt".text = str(Game.selectedMonsters[0]["Health"])
	
	
	# SET ATTACK NAMES
	for i in Game.selectedMonsters[0]["Attacks"]:
		var path = "../BattleUI/Fight/GridContainer/Attack " + str(((i) + 1))
		get_node(path).text = Game.selectedMonsters[0]["Attacks"][i]["Name"]


func _on_items_pressed() -> void:
	$Menu.hide()
	$Items.show()
	$Fight.hide()
	$"../BattleUI/Items/GridContainer/Heal".grab_focus()


func _on_run_pressed() -> void:
	$"../../UI/AnimationPlayer".play("TransIn")
	await get_tree().create_timer(1.5).timeout
	$"../../UI/AnimationPlayer".play("TransOut")
	$"../../Player/Camera2D2".enabled = true
	#print(self.get_path())
	get_parent().queue_free()
	get_tree().paused = false


func _on_attack_pressed(extra_arg_0: int) -> void:
	if Game.selectedMonsters[0]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var tempDic = Game.selectedMonsters[0]["Attacks"]
		$"../Enemy".get_child(0).hit(tempDic[extra_arg_0]["Name"], tempDic[extra_arg_0]["Damage"]) 
		$"../Action".text = Game.selectedMonsters[0]["Name"] + " has attacked for " + str(tempDic[0]["Damage"]) + " hp"
		get_parent().MonsterTurn()
