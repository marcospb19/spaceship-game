extends KinematicBody2D

var movement := Vector2(0 , 0)
var starting_position: Vector2

var current_angle: float
var starting_angle: float

func reset_position():
	set_position(starting_position)
	set_rotation_degrees(starting_angle)

# Should be called only one time, may
# be transformed to a constructor after
func set_starting_position(position , angle := 0.0):
	starting_position = position
	starting_angle    = angle
	reset_position()
