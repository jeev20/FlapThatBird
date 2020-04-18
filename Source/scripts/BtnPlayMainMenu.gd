extends TextureButton

onready var swoosh = get_tree().get_root().get_child(0).get_node("HUD").get_node("Swoosh").get_child(0)

func _ready():
	connect("pressed", self, "_on_pressed")

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Level.tscn")
		
func _on_pressed():
	swoosh.play(0)
	yield (swoosh, "finished")
	get_tree().change_scene("res://Level.tscn")
