extends Control

var maxHealth
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	maxHealth = $"../Enemy".get_child(0).health
	$HPBar.max_value = $"../Enemy".get_child(0).health
	$HPBar.value = $"../Enemy".get_child(0).health
	$Info.text = str($"../Enemy".get_child(0).name) + " LVL" + str($"../Enemy".get_child(0).level)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HPBar.value = $"../Enemy".get_child(0).health
	$HpTxt.text = str($"../Enemy".get_child(0).health) + "/" + str(maxHealth)
