extends CharacterBody2D

signal battle_triggered

#@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D2
@export var speed = 100

#func _ready():
	#$Area2D.connect("body_entered", self, "_on_body_entered")
	#


#const SPEED = 300.
#const JUMP_VELOCITY = -400.0
#
#
func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed *delta)
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

var battle = preload("res://battle/battle_scene.tscn")
 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		emit_signal("battle_triggered")
		print("Battle Triggered")
		$"../UI/AnimationPlayer".play("TransIn") # play black circle getting bigger
		%Level1.stop()
		%BattleMusic.play()
		%swordSound.play()
		%birds.stop()
		get_tree().paused = true # pause player movement and world movement
		await get_tree().create_timer(1.5).timeout # wait for TransIn to finish
		var battleTemp = battle.instantiate() # create battle scene
		get_parent().add_child(battleTemp) # add battlescene child to main
		queue_free() # prevent code from making multiple battle scenes
		$"../Player/Camera2D2".enabled = false # disable player camera so battle scene camera is correct
		$"../UI/AnimationPlayer".play("TransOut") # play black circle getting smaller

 
