extends "res://Vehicles/VehicleBase.gd"

var can_move := true
var can_rotate := true

var is_rotation_inertia_enabled := false
var rotation_speed := 0.0

func _handle_movement(up , down):
	if not can_move:
		return
	if up:
		movement.x += sin(current_angle) * 8
		movement.y -= cos(current_angle) * 8
	if down:
		movement.x -= sin(current_angle) * 4
		movement.y += cos(current_angle) * 4

func _handle_rotation(left , right):
	if not can_rotate:
		return
	if is_rotation_inertia_enabled:
		if left:
			rotation_speed -= deg2rad(0.05)
		if right:
			rotation_speed += deg2rad(0.05)
		self.rotate(rotation_speed)
	else:
		if left:
			self.rotate(-deg2rad(2))
		if right:
			self.rotate( deg2rad(2))

# This is great, ok?
func _physics_process(delta):
	current_angle = deg2rad(get_rotation_degrees())
