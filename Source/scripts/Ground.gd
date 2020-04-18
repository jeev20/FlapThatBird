extends StaticBody2D

onready var bottomright = get_node("bottomright")

onready var camera = get_tree().get_root().get_child(0).get_node("Camera")

signal destroyed
 
func _ready():
	add_to_group("grounds")
	pass
	

func _process(delta):
	if camera == null: return

	if bottomright.get_global_position().x <= camera.get_total_pos().x:
		queue_free()
		emit_signal("destroyed")
