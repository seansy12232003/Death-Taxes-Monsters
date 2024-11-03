extends StaticBody2D

var health = 100
var level = 1

func _ready():
	level = randi_range(1, 5)
	Game.dataBaseMonsters[0]["Defense"] = Game.calculate_defense(level)
	Game.dataBaseMonsters[0]["Strength"] = Game.calculate_strength(level)
	for i in Game.selectedMonsters[0]["Attacks"]:
		var path = "../BattleUI/Fight/GridContainer/Attack " + str(((i) + 1))
		Game.selectedMonsters[0]["Attacks"][i]["Damage"] = Game.calculate_attack_power(level)
		print(Game.selectedMonsters[0]["Attacks"][i]["Damage"])
	if get_parent().name == "Enemy": # call spawn animation if in battle scene
		spawn()  # Delay the spawn call until the next frame
		set_process(true)
		$AnimationPlayer.process_mode = Node.PROCESS_MODE_ALWAYS

func spawn(): # play animation for battle scene
	$AnimatedSprite2D.scale *= 3
	var animation_player = $AnimationPlayer
	await get_tree().create_timer(1).timeout
	animation_player.play("spawn", -1, 2) # play spawn and make it faster

func hit(anim, dmg): # animation for getting hit
	health -= dmg
	$Hit/Attack.play("hit")
	$Hit/NormalHitSound.play()
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("idle")
