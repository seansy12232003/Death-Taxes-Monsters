extends Node2D

var slow_speed = 20.0

var battle = preload("res://battle/battle_scene.tscn")


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


func _on_minotaur_battle_triggered() -> void:
		$"./UI/AnimationPlayer".play("TransIn") # play black circle getting bigger
		%Level1.stop()
		%BattleMusic.play()
		%swordSound.play()
		%birds.stop()
		get_tree().paused = true # pause player movement and world movement
		await get_tree().create_timer(1.5).timeout # wait for TransIn to finish
		var battleTemp = battle.instantiate() # create battle scene
		get_parent().add_child(battleTemp) # add battlescene child to main
		queue_free() # prevent code from making multiple battle scenes
		$"./Player/Camera2D2".enabled = false # disable player camera so battle scene camera is correct
		$"./UI/AnimationPlayer".play("TransOut") # play black circle getting smaller
