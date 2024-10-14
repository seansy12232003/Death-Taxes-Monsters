extends StaticBody2D

var health = 20
var level = 1

func _ready():
	level = randi_range(1, 5)
	spawn()  # Delay the spawn call until the next frame

func spawn():
	$AnimatedSprite2D.scale *= 3
	var animation_player = $AnimationPlayer
	animation_player.play("spawn", -1, 2) # play spawn and make it faster

func hit(anim, dmg):
	health -= dmg
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("idle")
