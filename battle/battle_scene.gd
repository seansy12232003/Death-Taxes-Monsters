extends CanvasLayer

var player = preload("res://Player/player.tscn")
var minotaur = preload("res://Monsters/minotaur.tscn")

var selected = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_path())
	$".".process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("add_minotaur")
	call_deferred("add_player")
	$BattleUI/Menu/GridContainer/Fight.grab_focus()
	

func add_player():
	var playertemp = player.instantiate()
	var sprite = playertemp.get_node("AnimatedSprite2D")
	if sprite:
		sprite.play("idle")
		sprite.scale *= 7
	$Player.add_child(playertemp)

func add_minotaur():
	var monstertemp = minotaur.instantiate()
	var sprite = monstertemp.get_node("AnimatedSprite2D")
	if sprite:
		sprite.play("idle")
	$Enemy.add_child(monstertemp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func MonsterTurn():
	$BattleUI/Menu.hide()
	$BattleUI/Fight.hide()
	$BattleUI/Items.hide()
	
	
	
	if $Enemy.get_child(0).health <= 0:
		$Enemy.get_child(0).get_node("AnimationPlayer").play("die")
		await get_tree().create_timer(2).timeout
		Game.addEXP(10)
		get_tree().paused = false
		queue_free()
	
	var damage = randi_range(10,15)
	$Action.text = "Enemy is thinking..."
	await get_tree().create_timer(2).timeout
	
	
	
	$Enemy.get_child(0).hit("attack", damage)
	$Action.text = "Enemy " + $Enemy.get_child(0).name + " has attacked using <placeholder> for " + str(damage) + " hp"
	Game.selectedMonsters[0]["Health"] -= damage
	$BattleUI/Menu/GridContainer/Fight.grab_focus()
	$BattleUI/Menu.show()
