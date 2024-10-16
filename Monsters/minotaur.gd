extends StaticBody2D

var health = 20
var level = 1

func _ready():
	level = randi_range(1, 5)
	if get_parent().name == "Enemy": # call spawn animation if in battle scene
		spawn()  # Delay the spawn call until the next frame
		set_process(true)
		$AnimationPlayer.process_mode = Node.PROCESS_MODE_ALWAYS

func spawn(): # play animation for battle scene
	$AnimatedSprite2D.scale *= 3
	var animation_player = $AnimationPlayer
	await get_tree().create_timer(1).timeout
	animation_player.play("spawn", -1, 2) # play spawn and make it faster

func hit(anim, dmg):
	health -= dmg
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("idle")
