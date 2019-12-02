extends "res://Vehicles/VehicleBase.gd"

var is_rotation_inertia_enabled := false
var rotation_speed := 0.0 # If inertia

var up: bool
var left: bool
var down: bool
var right: bool

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
