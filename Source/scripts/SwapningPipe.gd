extends Node2D


const SCENEPIPE = preload("res://scenes/Pipe.tscn")
const PIPE_WIDTH = 26
const OFFSET_Y = 55
const OFFSET_X = 65
const GROUND_HEIGHT = 55
const AMOUNTOFPIPE = 3

onready var camera = get_tree().get_root().get_child(0).get_node("Camera")
onready var viewWidth = get_viewport_rect().size[0]
onready var viewHeight = get_viewport_rect().size[1]

func _ready():
	var bird = get_tree().get_root().get_child(0).get_node("Bird")
	if bird:
		bird.connect("stateChanged", self, "on_bird_state_changed", [], CONNECT_ONESHOT)
		
func on_bird_state_changed(bird):
	if bird.get_state() == bird.STATE_FLAPPING:
		start()


func start():
	go_init_pos()
	for i in range(AMOUNTOFPIPE):
		spawn_and_move()

func go_init_pos():
	randomize()
	var init_pos = Vector2()
	init_pos.x = viewWidth + (PIPE_WIDTH/2) + 10
	init_pos.y = rand_range(0+OFFSET_Y, viewHeight-GROUND_HEIGHT-OFFSET_Y)
	
	# This ensures that when the game starts pipes spawn little farther
	if camera:
		init_pos.x += camera.get_total_pos().x
	
	set_position(init_pos)


func spawn_and_move():
	spawn_pipe()
	go_next_position()



func spawn_pipe():
	var new_pipe = SCENEPIPE.instance()
	new_pipe.set_position(get_position())
	new_pipe.connect("pipe_destroyed", self, "spawn_and_move")
	get_node("Container").add_child(new_pipe)
	

func go_next_position():
	randomize()
	var next_position = get_position()
	next_position.x += (PIPE_WIDTH/2) + OFFSET_X + (PIPE_WIDTH/2)
	next_position.y = rand_range(0+OFFSET_Y, viewHeight-GROUND_HEIGHT-OFFSET_Y)
	set_position(next_position)
