extends AnimatedSprite

const MEDAL_RADIUS = 11

onready var bird = get_tree().get_root().get_child(0).get_node("Bird")
onready var medal = get_parent().get_parent().get_node("ScoreLabelBest")

func _ready():
	to_random_pos()
	medal.connect("shown", self, "play", ["shine"])
	to_random_pos()
	#self.play("shine")
	pass


func to_random_pos():
	#if bird.get_state() == bird.STATE_GROUNDED:
	var rand_angle = deg2rad(rand_range(0,360))
	var rand_radius = rand_range(0, MEDAL_RADIUS)
	var x = rand_radius * cos(rand_angle) + MEDAL_RADIUS
	var y = rand_radius * sin(rand_angle) + MEDAL_RADIUS
	set_position(Vector2(x,y))
	pass

