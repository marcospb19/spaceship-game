extends "res://Vehicles/VehicleBase.gd"

const SPEED := 100
onready var sprite := $Sprite

func _rotate_sprites():
	sprite.rotate(deg2rad(5))

func set_projectile_trajectory(position: Vector2 , angle: float , parent_speed: float):
	var radians = deg2rad(angle)
	var projectile_speed = max(parent_speed + 50 , SPEED)
	print("projectile_speed = " , projectile_speed)
	print("parent_speed = " , parent_speed)
	.set_starting_position(position , angle)
	reset_position()
	movement = Vector2(cos(radians) , sin(radians)) * projectile_speed

func _handle_movement(delta: float):


func _physics_process(delta: float):
	_rotate_sprites()
	_handle_movement()
	var collision = move_and_collide(movement * delta)
	print("movement = " , movement)
