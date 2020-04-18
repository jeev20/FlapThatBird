extends Area2D

onready var sounds = get_tree().get_root().get_child(0).get_node("Sounds")
onready var game = get_node("/root/Level")

func _ready():
	connect("body_entered", self, "_on_body_enter")
	

func _on_body_enter(other_body):
	
	var bird = get_tree().get_root().get_child(0).get_node("Bird")
	if other_body.is_in_group("birds"):
		if bird.get_state() != bird.STATE_HIT or bird.get_state() != bird.STATE_GROUNDED:
			sounds.get_node("point").play()
			game.score_current += 1
			game.score_best = game.score_current
			
