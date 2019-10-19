extends KinematicBody2D

# Speed inertia to move_and_slide()
var motion = Vector2()
# Rotation inertia in radians
var rotation_angle = 0
# Current angle in radians
var current_angle

# (Units per second)²
const DIRECTIONAL_SPEED = 10
# In radians
const ROTATION_SPEED    = deg2rad(2)

var UP_BIND    = KEY_UP
var LEFT_BIND  = KEY_LEFT
var DOWN_BIND  = KEY_DOWN
var RIGHT_BIND = KEY_RIGHT

#func FireController(is_on , left_is_the_one_activated):
	#if is_on:
	#$FireExaustion/Orange.set_visible(true)
	#else:
		#$FireExaustion/Orange.set_visible(false)

func _ready():
	pass

func _physics_process(delta):
	current_angle = deg2rad(self.get_rotation_degrees())
	print(current_angle)
	print(self.rotation)
	
	if Input.is_key_pressed(LEFT_BIND):
		$FireExaustion/RightOrange.set_visible(true)
		self.rotate(-ROTATION_SPEED)
	else:
		$FireExaustion/RightOrange.set_visible(false)
		
	if Input.is_key_pressed(RIGHT_BIND):
		$FireExaustion/LeftOrange.set_visible(true)
		self.rotate( ROTATION_SPEED)
	else:
		$FireExaustion/LeftOrange.set_visible(false)
		
	# if Input.is_key_pressed(UP_BIND):
	if Input.is_key_pressed(UP_BIND):
		$FireExaustion/MainPurple.set_visible(true)
		motion.x += sin(current_angle) * DIRECTIONAL_SPEED
		motion.y -= cos(current_angle) * DIRECTIONAL_SPEED
	
	else:
		$FireExaustion/MainPurple.set_visible(false)
	motion = move_and_slide(motion)
