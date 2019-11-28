extends "res://Vehicles/VehicleBase.gd"

var can_move := true
var can_rotate := true

var is_rotation_inertia_enabled := false
var rotation_speed := 0.0 # If inertia

var up: bool
var left: bool
var down: bool
var right: bool

func _handle_movement(up , down , delta: float):
	if can_move:
		if up:
			movement.x += cos(radians_angle) * 7.5
			movement.y += sin(radians_angle) * 7.5
		if down:
			movement.x -= cos(radians_angle) * 4
			movement.y -= sin(radians_angle) * 4
		
		var collision = move_and_collide(movement * delta)
		if collision:
			check_collisions(collision)

func _handle_rotation(left: bool , right: bool):
	if can_rotate:
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
