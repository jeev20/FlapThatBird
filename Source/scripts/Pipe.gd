extends StaticBody2D

signal pipe_destroyed

onready var noderight = get_node("NodeRight")

onready var camera = get_tree().get_root().get_child(0).get_node("Camera")

func _ready():
	
	set_process(true)
	add_to_group("pipes")

func _process(delta):
	
	if camera == null: return
	
	if noderight.get_global_position().x <= camera.get_total_pos().x:
		queue_free()
		emit_signal("pipe_destroyed")
