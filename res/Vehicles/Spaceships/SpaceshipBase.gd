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

func _handle_rotation(left: bool , right: bool):
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

func _handle_sprites(up , left , down , right):
	$Sprites/Thrusters/MainThruster.set_visible(up)
	$Sprites/Thrusters/ReverseThruster.set_visible(down)
	$Sprites/Thrusters/LeftRotator.set_visible(right)
	$Sprites/Thrusters/RightRotator.set_visible(left)

# This is great, ok? Don't ask why
func _physics_process(delta):
	current_angle = deg2rad(get_rotation_degrees())
