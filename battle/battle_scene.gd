extends CanvasLayer

var player = preload("res://Player/player.tscn")
var minotaur = preload("res://Monsters/minotaur.tscn")

var selected = 1

# Called when the node enters the scene tree for the first time.
func _ready():
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
