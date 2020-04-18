extends Container


func _ready():
	var bird = get_tree().get_root().get_child(0).get_node("Bird")
	if bird:
		bird.connect("stateChanged", self, "_on_bird_state_changed")
	pass

func _on_bird_state_changed(bird):
	if bird.get_state() == bird.STATE_GROUNDED:# or bird.get_state() == bird.STATE_HIT:
		get_node("anim").play("anim")
		
