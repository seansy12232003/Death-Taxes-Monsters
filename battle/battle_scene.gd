extends CanvasLayer

var minotaur = preload("res://Monsters/minotaur.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var monstertemp = minotaur.instantiate()
	var sprite = monstertemp.get_node("AnimatedSprite2D")
	sprite.play("idle")
	$Enemy.add_child(monstertemp)
	$UI/Menu/GridContainer/Fight.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
