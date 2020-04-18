extends HBoxContainer

onready var game = get_node("/root/Level") 
onready var bird = get_tree().get_root().get_child(0).get_node("Bird")
const sprite_numbers = [ 
	preload("res://sprites/number_large_0.png"),
	preload("res://sprites/number_large_1.png"),
	preload("res://sprites/number_large_2.png"),
	preload("res://sprites/number_large_3.png"),
	preload("res://sprites/number_large_4.png"),
	preload("res://sprites/number_large_5.png"),
	preload("res://sprites/number_large_6.png"),
	preload("res://sprites/number_large_7.png"),
	preload("res://sprites/number_large_8.png"),
	preload("res://sprites/number_large_9.png")
]

func _ready():
	game.connect("score_current_changed", self, "_on_score_current_change")
	_on_score_current_change()
	if bird:
		bird.connect("stateChanged", self, "_on_bird_stateChaged")

func _on_score_current_change():
	set_number(game.score_current)

func _on_bird_stateChaged(bird):
	if bird.get_state() == bird.STATE_GROUNDED:
		hide()
	if bird.get_state() == bird.STATE_HIT:
		hide()

func set_number(number):
	for child in get_children():
		child.queue_free()
	
	var str_nummber = String(number)
	var digits = []
	
	for i in range(str_nummber.length()):
		digits.append(str_nummber[i].to_int())
	
	for digit in digits:
		var texture_rect = TextureRect.new()
		texture_rect.set_texture(sprite_numbers[digit])
		add_child(texture_rect)
