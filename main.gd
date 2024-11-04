extends Node2D

var slow_speed = 20.0

var battle = preload("res://battle/battle_scene.tscn")

var kingdom_entry_position = Vector2(950, 1695)
var forest_exit_position = Vector2(905, 642)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_pos($StartPosition.position) # set position of player to start position

# Called every frame. 'delta' is the elapsed timea since the previous frame.
func _process(delta: float) -> void:
	get_node("Player/CanvasLayer/Health").text = str(Game.selectedMonsters[0]["Health"])
	


func _on_stairs_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_speed(slow_speed)


func _on_stairs_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.reset_speed()


func _on_minotaur_battle_triggered() -> void:
	pass



func _on_teleport_area_forest_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$FadeAnimationPlayer.play("fade_in")
		await get_tree().create_timer(2).timeout
		body.position = kingdom_entry_position
		get_tree().paused = true
		$FadeAnimationPlayer.play("fade_out")
		await get_tree().create_timer(1).timeout
		get_tree().paused = false




func _on_teleport_area_kingdom_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$FadeAnimationPlayer.play("fade_in")
		await get_tree().create_timer(1.5).timeout
		body.position = forest_exit_position
		get_tree().paused = true
		await get_tree().create_timer(2).timeout
		$FadeAnimationPlayer.play("fade_out")
		get_tree().paused = false


func _on_inventory_button_pressed() -> void:
	if get_node("Player/Inventory").offset.y == -500:
		get_node("Player/Inventory/AnimationPlayer").play("TransIn")
	elif get_node("Player/Inventory").offset.y == 1000:
		get_node("Player/Inventory/AnimationPlayer").play("TransIn")
	elif get_node("Player/Inventory").offset.y == 150:
		get_node("Player/Inventory/AnimationPlayer").play("TransOut")
	get_node("Player/Inventory/InvContainer").fillInventorySlots()
	



func _on_instructions_pressed() -> void:
	if get_node("Player/Instructions").offset.y == -500:
		get_node("Player/Instructions/AnimationPlayer").play("TransIn")
	elif get_node("Player/Instructions").offset.y == 1000:
		get_node("Player/Instructions/AnimationPlayer").play("TransIn")
	elif get_node("Player/Instructions").offset.y == 150:
		get_node("Player/Instructions/AnimationPlayer").play("TransOut")
