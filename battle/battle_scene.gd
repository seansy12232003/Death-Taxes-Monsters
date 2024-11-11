extends CanvasLayer

var player = preload("res://Player/player.tscn")
var minotaur = preload("res://Monsters/minotaur.tscn")
var currPlayerPosition
var startHealth

# monster damage stats
var monsterLevel
var monsterDefense

# player damage stats
var playerLevel
var playerDefense

# selected monster, or encountered monster ID, change when encountering other monsters
var selected

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("add_minotaur")
	call_deferred("add_player")
	currPlayerPosition = $"../../../Player".position
	startHealth = Game.selectedMonsters[0]["Health"]
	$BattleUI/Menu/GridContainer/Fight.grab_focus()
	playerLevel = Game.selectedMonsters[0]["Level"]
	playerDefense = Game.selectedMonsters[0]["Defense"]
	

func add_player():
	var playertemp = player.instantiate()
	var sprite = playertemp.get_node("AnimatedSprite2D")
	if sprite:
		sprite.play("idle")
		sprite.scale *= 7
	$Player.add_child(playertemp)

func add_minotaur():
	selected = 1 # set to respective monster ID in Game.gd
	var monstertemp = minotaur.instantiate()
	var sprite = monstertemp.get_node("AnimatedSprite2D")
	if sprite:
		sprite.play("idle")
	$Enemy.add_child(monstertemp)
	$Action.text = "You've encountered a Minotaur!"
	monsterLevel = Game.dataBaseMonsters[1]["Level"]
	monsterDefense = Game.dataBaseMonsters[1]["Defense"]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func MonsterTurn():
	# hide menus
	$BattleUI/Menu.hide()
	$BattleUI/Fight.hide()
	$BattleUI/Items.hide()
	var monsterLevel = $Enemy.get_child(0).level
	
	# check if enemy is dead
	if $Enemy.get_child(0).health <= 0:
		var expToGain = floor(Game.calculate_exp_per_monster(monsterLevel))
		$Action.text = "You defeated the " + Game.dataBaseMonsters[selected]["Name"] + "!"
		$Enemy.get_child(0).get_node("AnimationPlayer").play("die")
		await get_tree().create_timer(2).timeout
		$Action.text = "You gained " + str(expToGain) + " exp!"
		await get_tree().create_timer(2).timeout
		Game.addEXP(expToGain) # add exp to player and scale exp with monster level
		$"../../../Player/Level/RichTextLabel".text = "Level " + str(Game.selectedMonsters[0]["Level"]) + "  " + str(Game.selectedMonsters[0]["Exp"]) + "/" + str(Game.selectedMonsters[0]["MaxExp"])
		print(expToGain)
		$"../../../Player".position = currPlayerPosition
		get_tree().paused = false
		$"../../../UI/AnimationPlayer".play("TransIn")
		await get_tree().create_timer(1.5).timeout
		$"../../../Player/Camera2D2".enabled = true
		queue_free()
		$"../../../UI/AnimationPlayer".play("TransOut")
		Game.selectedMonsters[0]["Health"] = startHealth
		var minotaur = $"../".get_child(0) # get minotaur
		minotaur.queue_free() # delete minotaur
	
	# wait for a second and show what the player did
	await get_tree().create_timer(1.5).timeout 
	
	# choosing enemy attack
	var attack = randi_range(0,2) # chooses a random attack
	var attackDamage = Game.dataBaseMonsters[selected]["Attacks"][attack]["Damage"] # gets damage of the attack
	var damage = Game.calculate_damage(playerDefense,attackDamage,monsterLevel, false)# gets damage of the attack
	#monsterLevel, attackDamage, playerDefense
	
	# Pause for battle suspense
	$Action.text = Game.dataBaseMonsters[selected]["Name"] + " is thinking..."
	await get_tree().create_timer(2).timeout
	
	# play/display attack and refocus
	$Enemy.get_child(0).get_node("AnimatedSprite2D").play("attack")
	$Action.text = Game.dataBaseMonsters[selected]["Name"] + " has attacked using " + Game.dataBaseMonsters[selected]["Attacks"][attack]["Name"] + " for " + str(damage) + " hp"
	Game.selectedMonsters[0]["Health"] -= damage
	await get_tree().create_timer(1).timeout # wait for attack animation to be done
	$Enemy.get_child(0).get_node("AnimatedSprite2D").play("idle")
	
		#check if player is dead
	if Game.selectedMonsters[0]["Health"] <= 0:
		$Player.get_child(0).get_node("AnimatedSprite2D").play("die")
		$Action.text = "You have died!"
		await get_tree().create_timer(2).timeout
		$"../../../Player".position = $"../../../StartPosition".position
		get_tree().paused = false
		$"../../../UI/AnimationPlayer".play("TransIn")
		await get_tree().create_timer(1.5).timeout
		$"../../../Player/Camera2D2".enabled = true
		queue_free()
		$"../../../UI/AnimationPlayer".play("TransOut")
		Game.selectedMonsters[0]["Health"] = startHealth
	else:
		$BattleUI/Menu/GridContainer/Fight.grab_focus()
		$BattleUI/Menu.show()
		await get_tree().create_timer(1.5).timeout # show what the monster did
	
