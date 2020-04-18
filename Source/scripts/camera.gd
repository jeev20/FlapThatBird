extends Camera2D

# Go to parent of camera, find bird node
onready var bird =  get_parent().get_node("Bird")

func _ready():
	set_process(true)


func _process(delta):
	# Get x position of bird
	var bird_Xpos = bird.get_position().x

	# Set camera x position to bird's x position
	set_position(Vector2(bird_Xpos, get_position().y))

func get_total_pos():
	return get_position() + get_offset()

