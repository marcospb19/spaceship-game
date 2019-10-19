extends KinematicBody2D


# Speed Constants
#
# (Units per second)²
const BOOST_SPEED_CONSTANT: int = 10
# In radians
const ROTATION_SPEED_CONSTANT: float = deg2rad(2)
# In radians
const INERTIA_ROTATION_SPEED_CONSTANT: float = deg2rad(0.05)


# Attributes of the Spaceship physics
#
# Spaceship's movement speed, respects inertia
var motion: Vector2
# Rotation inertia option. Specified at instanciation
var is_rotation_inertia_enabled: bool 
# Rotation inertia in radians, if inertia is enabled
var rotation_speed: float = 0
# Can change when ship is uncontrollable
var is_able_to_move: bool = true
# Can change with other debuffs 
var is_able_to_shoot: bool = true

# Using WASD to represent the control keys
var key_up    = KEY_UP
var key_left  = KEY_LEFT
var key_down  = KEY_DOWN
var key_right = KEY_RIGHT

# Projectiles
onready var missile = preload("res://Projectile/Projectile.tscn")

func __handle_weapons(fire):
	if fire:
		var node = missile.instance()
		node.get_node("KinematicBody2D").set_trajectory_angle(self.get_rotation_degrees())
		self.get_parent().add_child(node)


# Control the propulsor sprites
func __handle_sprites(up , left , down , right):
	
	$FireExaustion/MainPurple.set_visible(up)
	$FireExaustion/BackwardsPurple.set_visible(down)
	$FireExaustion/LeftOrange.set_visible(right)
	$FireExaustion/RightOrange.set_visible(left)


func __handle_input(up , left , down , right):
	
	# Current angle in radians, used to calculate boost
	var current_angle = deg2rad(self.get_rotation_degrees())
	
	# Handle boost
	if up:
		motion.x += sin(current_angle) * BOOST_SPEED_CONSTANT
		motion.y -= cos(current_angle) * BOOST_SPEED_CONSTANT
	if down:
		motion.x -= sin(current_angle) * BOOST_SPEED_CONSTANT / 2 # Reverse boost force is
		motion.y += cos(current_angle) * BOOST_SPEED_CONSTANT / 2 # main boost divided by 2
	
	# Handle rotation
	# Rotation with inertia
	if is_rotation_inertia_enabled:
		if left:
			rotation_speed -= INERTIA_ROTATION_SPEED_CONSTANT
		if right:
			rotation_speed += INERTIA_ROTATION_SPEED_CONSTANT
		
		self.rotate(rotation_speed)
	# Flat rotation (without inertia)
	else:
		
		if left:
			self.rotate(-ROTATION_SPEED_CONSTANT)
		if right:
			self.rotate( ROTATION_SPEED_CONSTANT)


func _physics_process(delta):
	
	# WASD represents the commands
	var up    = Input.is_key_pressed(key_up)
	var left  = Input.is_key_pressed(key_left)
	var down  = Input.is_key_pressed(key_down)
	var right = Input.is_key_pressed(key_right)
	
	if is_able_to_move:
		__handle_input  (up , left , down , right)
		__handle_sprites(up , left , down , right)
	
	## var fire = Input.is_key_just_pressed(KEY_SPACE)
	
	#if is_able_to_shoot:
#		__handle_weapons(fire)
	
	motion = move_and_slide(motion)
