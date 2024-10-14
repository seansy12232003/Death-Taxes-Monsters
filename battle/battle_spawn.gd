extends Area2D


var battle = preload("res://battle/battle_scene.tscn")

func _on_body_entered(body: Node2D) -> void: # on encountering enemy
	if "Player" in body.name: # if player runs into enemy
		$"../UI/AnimationPlayer".play("TransIn") # play black circle getting bigger
		%Level1.stop()
		%BattleMusic.play()
		get_tree().paused = true # pause player movement and world movement
		await get_tree().create_timer(1.5).timeout # wait for TransIn to finish
		var battleTemp = battle.instantiate() # create battle scene
		get_parent().add_child(battleTemp) # add battlescene child to main
		queue_free() # prevent code from making multiple battle scenes
		$"../Player".get_node("Camera2D").enabled = false # disable player camera so battle scene camera is correct
		$"../UI/AnimationPlayer".play("TransOut") # play black circle getting smaller

 
