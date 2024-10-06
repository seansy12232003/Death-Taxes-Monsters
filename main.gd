extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_pos($StartPosition.position) # set position of player to start position


# Called every frame. 'delta' is the elapsed timea since the previous frame.
func _process(delta: float) -> void:
	pass
