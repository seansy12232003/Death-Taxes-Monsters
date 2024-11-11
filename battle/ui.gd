extends Control

var startHealth

func _ready() -> void:
	startHealth = Game.selectedMonsters[0]["Health"]

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
	


func _on_items_pressed() -> void: # open items menu
	$Menu.hide()
	$Items.show()
	$Fight.hide()
	$"../BattleUI/Items/GridContainer/Heal".grab_focus()


func _on_run_pressed() -> void: # run from battle
	$"../../../../UI/AnimationPlayer".play("TransIn")
	await get_tree().create_timer(1.5).timeout
	$"../../../../UI/AnimationPlayer".play("TransOut")
	$"../../../../Player/Camera2D2".enabled = true
	var battle_scene = get_parent()
	if battle_scene:
		battle_scene.queue_free()
		$"../../../../Player/".set_pos($"../../../../StartPosition".position) # set player position to start position to ensure no looping of battle scene instantiation
	Game.selectedMonsters[0]["Health"] = startHealth
	get_tree().paused = false
	


func _on_attack_pressed(extra_arg_0: int) -> void: # attack menu
	print("Attack pressed")
	if Game.selectedMonsters[0]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var tempDic = Game.selectedMonsters[0]["Attacks"] # get the players attacks
		var isWeak = false
		if(Game.dataBaseMonsters[$"..".selected]["Weakness"] == tempDic[extra_arg_0]["Type"]):
			isWeak = true
		var damage = Game.calculate_damage(Game.dataBaseMonsters[$"..".selected]["Defense"], tempDic[extra_arg_0]["Damage"], Game.selectedMonsters[0]["Level"], isWeak)
		$"../Enemy".get_child(0).hit(damage) # use hit function in monster scene and send animation name and damage
		$"../Action".text = Game.selectedMonsters[0]["Name"] + " has attacked for " + str(damage) + " hp. " # change text in action section of battle menu
		if isWeak:
			$"../Action".text += "Critical Hit!"
		get_parent().MonsterTurn() # call monster turn


func _on_heal_pressed() -> void:
	pass
