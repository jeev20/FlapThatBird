extends TextureButton

func _ready():
	connect("pressed", self, "on_pressed")
	grab_focus()
	pass

func on_pressed():
	var bird = get_tree().get_root().get_child(0).get_node("Bird")
	if bird:
		bird.set_state(bird.STATE_FLAPPING)
		hide()
	
