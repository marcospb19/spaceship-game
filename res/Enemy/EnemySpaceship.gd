extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

var key_up: int
var key_left: int
var key_down: int
var key_right: int
var shoot_action: String

onready var weapon := preload("res://Weapons/Weapon.gd").new()

func controls(keys: Array , action: String , rotation_inertia := false):
	key_up    = keys[0]
	key_left  = keys[1]
	key_down  = keys[2]
	key_right = keys[3]
	is_rotation_inertia_enabled = rotation_inertia
	shoot_action = action

func _handle_sprites(up , left , down , right):
	$Sprites/Thrusters/MainThruster.set_visible(up)
	$Sprites/Thrusters/ReverseThruster.set_visible(down)
	$Sprites/Thrusters/LeftRotator.set_visible(right)
	$Sprites/Thrusters/RightRotator.set_visible(left)

func _physics_process(delta):
	var up    = Input.is_key_pressed(KEY_UP)
	var left  = Input.is_key_pressed(KEY_LEFT)
	var down  = Input.is_key_pressed(KEY_DOWN)
	var right = Input.is_key_pressed(KEY_RIGHT)
	
	_handle_sprites(up , left , down , right)
	
	_handle_movement(up , down)
	_handle_rotation(left , right)
	
	if Input.is_action_just_pressed(shoot_action):
		weapon.fire()

	movement = move_and_slide(movement)
