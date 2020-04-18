extends TextureButton


func _ready():
	connect("pressed", self, "_on_pressed")
	pass

func _on_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	
