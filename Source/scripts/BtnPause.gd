extends TextureButton

onready var bird =  get_parent().get_parent().get_node("Bird")

func _ready():
	# Pausing
	connect("pressed", self, "_on_pressed")
	# Dont need pause button when gameover
	if bird:
		bird.connect("stateChanged", self, "_on_bird_state_changed")
	pass


func _on_pressed():
	get_tree().set_pause(true)


func _on_bird_state_changed(bird):
	if bird.get_state() == bird.STATE_HIT: 
		hide()
	if bird.get_state() == bird.STATE_GROUNDED: 
		hide()
