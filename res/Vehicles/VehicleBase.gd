extends KinematicBody2D

var starting_position: Vector2
var starting_angle: float
var movement := Vector2(0 , 0)

var current_angle := 0.0
var radians_angle := 0.0

var group: int

func self_destroy():
	print(self.name , " destroyed!.")
	self.queue_free()

func reset_position():
	movement = Vector2(0 , 0)
	set_position(starting_position)
	set_rotation_degrees(starting_angle)

func set_starting_position(position: Vector2 , angle: float):
	starting_position = position
	starting_angle    = angle
	reset_position()

# Virtual Function
func check_collisions(collision_object: KinematicCollision2D):
	print("Calling virtual function")

func _physics_process(delta):
	current_angle = get_rotation_degrees()
	radians_angle = deg2rad(current_angle)
