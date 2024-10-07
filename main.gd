extends Node2D

var slow_speed = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_pos($StartPosition.position) # set position of player to start position

# Called every frame. 'delta' is the elapsed timea since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_stairs_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_speed(slow_speed)


func _on_stairs_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.reset_speed()
