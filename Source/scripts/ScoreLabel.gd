extends Label

onready var game = get_node("/root/Level")

func _ready():
	game.connect("score_current_changed", self, "_on_score_current_change")
	set_text(String(game.score_current))
	pass

func _on_score_current_change():
	set_text(String(game.score_current))
	

