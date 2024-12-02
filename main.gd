extends Node2D

var slow_speed = 30.0

var battle = preload("res://battle/battle_scene.tscn")
var kingdom_entry_position = Vector2(985, 1695)
var forest_exit_position = Vector2(875, 642)
var castle_entry_position = Vector2(2793, 1110)
var kingdom_exit_position = Vector2(1385,2075)
var level
var player: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("notification").hide()
	get_node("Title").show()
	get_node("Dialogue/DialogueBox").hide()
	get_node("GameOverScreen").hide()
	get_node("Dialogue/DialogueBox/Panel/Label").text = ""
	$Player.set_pos($StartPosition.position) # set position of player to start position
	level = 1 # Level
	Game.selectedMonsters[0]["Level"] = 1
	Game.selectedMonsters[0]["Defense"] = Game.calculate_defense(level) # Defense
	
	#Set attack power of every attack depending on stats
	for i in Game.selectedMonsters[0]["Attacks"]:
		var path = "../BattleUI/Fight/GridContainer/Attack " + str(((i) + 1))
		Game.selectedMonsters[0]["Attacks"][i]["Damage"] = Game.calculate_attack_power(Game.selectedMonsters[0]["Attacks"][i]["Damage"], level)
		print(Game.selectedMonsters[0]["Attacks"][i]["Name"])
		print(Game.selectedMonsters[0]["Attacks"][i]["Damage"])

# Called every frame. 'delta' is the elapsed timea since the previous frame.
func _process(delta: float) -> void:
	#get_node("Player/CanvasLayer/Health").text = str(Game.selectedMonsters[0]["Health"])
	pass


func _on_stairs_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_speed(slow_speed)


func _on_stairs_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.reset_speed()


func _on_teleport_area_forest_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		$FadeAnimationPlayer.play("fade_in")
		player.can_move = false
		get_node("transitionsound").play()
		await get_tree().create_timer(2).timeout
		body.position = kingdom_entry_position
		get_tree().paused = true
		$FadeAnimationPlayer.play("fade_out")
		await get_tree().create_timer(1).timeout
		get_tree().paused = false
		player.can_move = true
		get_node("level2").play()



func _on_teleport_area_kingdom_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		$FadeAnimationPlayer.play("fade_in")
		player.can_move = false
		await get_tree().create_timer(1.5).timeout
		body.position = forest_exit_position
		get_tree().paused = true
		get_node("transitionsound").play()
		await get_tree().create_timer(2).timeout
		$FadeAnimationPlayer.play("fade_out")
		get_tree().paused = false
		player.can_move = true
		get_node("level1").play()
		get_node("level2").stop()

func _on_teleport_area_castle_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		$FadeAnimationPlayer.play("fade_in")
		player.can_move = false
		await get_tree().create_timer(1.5).timeout
		body.position = kingdom_exit_position
		get_tree().paused = true
		get_node("transitionsound").play()
		await get_tree().create_timer(2).timeout
		$FadeAnimationPlayer.play("fade_out")
		get_tree().paused = false
		player.can_move = true
		get_node("level2").play()
		get_node("level3").stop()

func _on_teleport_area_kingdom_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		$FadeAnimationPlayer.play("fade_in")
		player.can_move = false
		await get_tree().create_timer(1.5).timeout
		body.position = castle_entry_position
		get_tree().paused = true
		get_node("transitionsound").play()
		await get_tree().create_timer(2).timeout
		$FadeAnimationPlayer.play("fade_out")
		get_tree().paused = false
		player.can_move = true
		get_node("level3").play()
		get_node("level2").stop()

func _on_inventory_button_pressed() -> void:
	if get_node("Player/Inventory").offset.y == -500:
		get_node("Player/Inventory/AnimationPlayer").play("TransIn")
	elif get_node("Player/Inventory").offset.y == 1000:
		get_node("Player/Inventory/AnimationPlayer").play("TransIn")
	elif get_node("Player/Inventory").offset.y == 150:
		get_node("Player/Inventory/AnimationPlayer").play("TransOut")
	get_node("Player/Inventory/InvContainer").fillInventorySlots()
	



func _on_instructions_pressed() -> void:
	if get_node("Player/Instructions").offset.y == -500:
		get_node("Player/Instructions/AnimationPlayer").play("TransIn")
	elif get_node("Player/Instructions").offset.y == 1000:
		get_node("Player/Instructions/AnimationPlayer").play("TransIn")
	elif get_node("Player/Instructions").offset.y == 150:
		get_node("Player/Instructions/AnimationPlayer").play("TransOut")
		


func _on_documented_collected():
	if Global.documents == 0:
		get_node("notification").show()
		get_node("notification/Timer2").start()
	Global.documents+=1
	print("Documents collected: ", Global.documents)

func _on_taxdocuments_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_taxdocuments_2_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_taxdocuments_3_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_taxdocuments_4_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_taxdocuments_5_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_taxdocuments_6_collected() -> void:
	_on_documented_collected()
	get_node("Player/Tax Documents/Label").text = "Documents collected: " + str(Global.documents)


func _on_timer_2_timeout() -> void:
	get_node("notification").hide()
