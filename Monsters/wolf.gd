extends StaticBody2D

var health = 100
var level = 1

func _ready():
	print(self.get_path())
	# set stats
	level = $"../../../".get_node("Wolf").level
	Game.dataBaseMonsters[1]["Defense"] = Game.calculate_defense(level) # Defense
	print("Defense " + str(Game.dataBaseMonsters[1]["Defense"]))
	
	#Set attack power of every attack depending on stats
	for i in Game.dataBaseMonsters[1]["Attacks"]:
		var path = "../BattleUI/Fight/GridContainer/Attack " + str(((i) + 1))
		Game.dataBaseMonsters[1]["Attacks"][i]["Damage"] = Game.calculate_attack_power(Game.dataBaseMonsters[1]["Attacks"][i]["Damage"], level)
		print(Game.dataBaseMonsters[1]["Attacks"][i]["Name"])
		print(Game.dataBaseMonsters[1]["Attacks"][i]["Damage"])
		
		
	# spawn enemy if in battle scene
	if get_parent().name == "Enemy": # call spawn animation if in battle scene
		spawn()  # Delay the spawn call until the next frame
		set_process(true)
		$AnimationPlayer.process_mode = Node.PROCESS_MODE_ALWAYS

func spawn(): # play animation for battle scene
	$AnimatedSprite2D.scale *= 3
	var animation_player = $AnimationPlayer
	await get_tree().create_timer(1).timeout
	animation_player.play("spawn", -1, 2) # play spawn and make it faster

func hit(dmg): # animation for getting hit
	health -= dmg
	$Hit/Attack.play("hit")
	$Hit/NormalHitSound.play()
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("idle")
