extends TextureButton

onready var fade = load("res://scenes/Fade.tscn").instance()
onready var sounds = get_tree().get_root().get_child(0).get_node("Sounds")


func _ready():
	connect("pressed", self, "_on_pressed")
	pass

func _on_pressed():
	var swoosh = sounds.get_node("Swoosh")
	swoosh.play()
	yield(swoosh, "finished")
	get_tree().change_scene("res://Level.tscn")
	

