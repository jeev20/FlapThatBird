extends Node

var score_best = 0 setget _set_score_best
var score_current = 0 setget _set_score_current


const MEDAL_BRONZE = 10
const MEDAL_SILVER = 20
const MEDAL_GOLD = 30
const MEDAL_PLATINUM = 40

signal score_best_changed
signal score_current_changed

func _ready():
	pass

func _set_score_best(new_value):
	score_best = new_value
	emit_signal("score_best_changed")

func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
