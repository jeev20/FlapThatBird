extends RigidBody2D

const JUMP = 150
const STATE_FLYING = 0
const STATE_FLAPPING = 1
const STATE_HIT = 2
const STATE_GROUNDED = 3

signal stateChanged

var xvelocity = 50

# Sound signals
onready var sounds = get_parent().get_node("Sounds")
onready var state = FlyingState.new(self)

func _ready():
	set_process_input(true)
	set_process(true)
	add_to_group("birds")
	connect("body_entered", self, "_on_body_enter")
	

func _process(delta):
	state.update(delta)
	


func _input(event):
	state.input(event)


	
# handling collisions
func _on_body_enter(other_body):
	if state.has_method("on_body_enter"):
		state.on_body_enter(other_body)


func set_state(new_state):
	state.exit()
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundState.new(self)
	emit_signal("stateChanged", self)

func get_state():
	if state is FlyingState:
		return STATE_FLYING
	if state is FlappingState:
		return STATE_FLAPPING
	if state is HitState:
		return STATE_HIT
	if state is GroundState:
		return STATE_GROUNDED

#--------------------------------Finite State Machine--------
#Flying State
class FlyingState:
	
	var bird
	var prev_gravity_scale 
	func _init(bird):
		self.bird = bird
		prev_gravity_scale = bird.get_gravity_scale()
		# Every time it goes up  start the animation
		bird.get_node("SpriteBird").play("fly")
		bird.set_gravity_scale(0)
	func update(delta):
		pass
	
	func input(event):
		#Set a constant velocity
		bird.linear_velocity.x = bird.xvelocity
	func exit():
		bird.set_gravity_scale(prev_gravity_scale)
		bird.get_node("SpriteBird").set_position(Vector2(0,0))
		pass

#Flapping State
class FlappingState:
	var bird
	func _init(bird):
		self.bird = bird
		flap()
		
	func update(delta):
		if rad2deg(bird.get_rotation()) < -30:
			bird.set_rotation(deg2rad(-30))
			bird.set_angular_velocity(0)
		if bird.get_linear_velocity().y > 0:
			bird.set_angular_velocity(1.5)
			
		
	func flap():
		#Set a constant velocity
		bird.linear_velocity.x = bird.xvelocity
		# Set a linear velocity in the y direction
		bird.linear_velocity.y =  -JUMP
		# This gives the illusion of bird rotating up
		bird.set_angular_velocity(-3)
		# Every time it goes up  start the animation
		bird.get_node("SpriteBird").play("fly")
		# Play sound
		bird.sounds.get_node("wing").play()
		
		
		
	# Collision handling with groups for pipes and grounds
	func on_body_enter(other_body):
		if other_body.is_in_group("pipes"):
			bird.set_state(bird.STATE_HIT)
		elif other_body.is_in_group("grounds"):
			bird.set_state(bird.STATE_GROUNDED)
		
	func input(event):
		if Input.is_action_pressed("ui_select"):
			flap()
		if not event is InputEventScreenTouch:
			return
		if event.pressed:
			flap()

	func exit():
		pass

#Hit State
class HitState:
	var bird
	func _init(bird):
		
		self.bird = bird
		bird.get_node("BirdAnim").stop()
		bird.get_node("SpriteBird").play("idle")
		bird.linear_velocity = Vector2(-40,0)
		bird.set_angular_velocity(-6)
		# Play sound
		bird.sounds.get_node("hit").play()
		
		var other_body = bird.get_colliding_bodies()[0]
		#bird.add_colision_exception_with(other_body)
		
	func update(delta):
		pass
	
	func input(event):
		pass
		
	# Collision handling with ground and transting states
	func on_body_enter(other_body):
		if other_body.is_in_group("grounds"):
			# Play sound
			bird.sounds.get_node("die").play()
			bird.set_state(bird.STATE_GROUNDED)
	func exit():
		pass


#Ground State
class GroundState:
	var bird
	func _init(bird):
		self.bird = bird
		bird.sounds.get_node("die").play()
		bird.get_node("BirdAnim").stop()
		bird.get_node("SpriteBird").play("idle")
		bird.linear_velocity = Vector2(0,0)
		bird.set_angular_velocity(0)
		
		
	func update(delta):
		pass
	
	func input(event):
		pass
	func exit():
		pass



