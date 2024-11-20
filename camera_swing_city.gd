extends Area2D

@export var zoom_out_factor: Vector2 = Vector2(3, 3)  # How much the camera should zoom out
@export var pan_duration: float = 2.0  # Duration of the pan
@export var return_duration: float = 1.0  # Duration to return to the original position
@export var preview_target_position: Vector2 = Vector2()  # The target position for the preview


var original_zoom: Vector2
var original_position: Vector2
var camera: Camera2D
var player: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Camera2D2"):
		player = body
		camera = body.get_node("Camera2D2")
		original_zoom = camera.zoom
		original_position = camera.position
		disable_player_movement()
		preview_map()
		
		
func disable_player_movement():
	print("can move method tirggered")
	player.can_move = false

func enable_player_movement():
	print("back to move")
	player.can_move = true

func preview_map():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", zoom_out_factor, pan_duration).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera, "position", preview_target_position, pan_duration).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_interval(1.0)
	tween.tween_property(camera, "position", original_position, return_duration).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera, "zoom", original_zoom, return_duration).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(Callable(self, "enable_player_movement"))
	tween.tween_callback(Callable(self, "queue_free"))
