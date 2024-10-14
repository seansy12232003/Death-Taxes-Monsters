extends CanvasLayer

var minotaur = preload("res://Monsters/minotaur.tscn")
var player = preload("res://Player/player.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var monstertemp = minotaur.instantiate()
	monstertemp.get_node("AnimatedSprite2D").play("idle")
	$Enemy.add_child(monstertemp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
