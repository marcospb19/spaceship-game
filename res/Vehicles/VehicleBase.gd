extends KinematicBody2D

var starting_position: Vector2
var starting_angle: float
var movement := Vector2(0 , 0)

var current_angle := 0.0
var radians_angle := 0.0

var can_move := true
var can_rotate := true

var group: int

func repel(other , multiplier: float):
	print("Reppellingnngg")
	var vector = (get_position() - other.get_position()).normalized() * 50
	
	if other.has_method("_handle_movement"):
		multiplier *= (movement.length() + other.movement.length()) / 100.0
		
	movement += vector * multiplier

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

func _handle_movement(up , down , delta: float) -> KinematicCollision2D:
	if can_move:
		if up:
			movement.x += cos(radians_angle) * 8
			movement.y += sin(radians_angle) * 8
		if down:
			movement.x -= cos(radians_angle) * 4
			movement.y -= sin(radians_angle) * 4
		
		return move_and_collide(movement * delta)
	return null

# Virtual Function
func check_collisions(collision_object: KinematicCollision2D):
	print("Calling virtual function, THIS IS BAD!")

func _physics_process(delta):
	current_angle = get_rotation_degrees()
	radians_angle = deg2rad(current_angle)
