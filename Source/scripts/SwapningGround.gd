extends Node2D


const SCENEGROUND = preload("res://scenes/Ground.tscn")
const GROUNDWIDTH = 168
const AMOUNTOFGROUNDINSTANCES = 2

func _ready():
	for i in range(AMOUNTOFGROUNDINSTANCES):
		spawn_and_move()
		spawn_and_move()

func spawn_and_move():
	spawn_ground()
	go_next_position()


func spawn_ground():
	var new_ground = SCENEGROUND.instance()
	new_ground.set_position(get_position())
	new_ground.connect("destroyed", self, "spawn_and_move")
	get_node("Container").add_child(new_ground)
	

func go_next_position():
	set_position(get_position() + Vector2(GROUNDWIDTH,0) )
