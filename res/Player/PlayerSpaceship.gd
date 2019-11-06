extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

var key_up: int
var key_left: int
var key_down: int
var key_right: int
var shoot_action: String
var id: int

onready var weapon := preload("res://Weapons/Weapon.gd").new()

func set_controls(keys: Array , action: String , rotation_inertia := false):
	key_up    = keys[0]
	key_left  = keys[1]
	key_down  = keys[2]
	key_right = keys[3]
	is_rotation_inertia_enabled = rotation_inertia
	shoot_action = action

func _physics_process(delta):
	var up    = Input.is_key_pressed(key_up)
	var left  = Input.is_key_pressed(key_left)
	var down  = Input.is_key_pressed(key_down)
	var right = Input.is_key_pressed(key_right)
	
	_handle_sprites(up , left , down , right)
	
	_handle_movement(up , down)
	_handle_rotation(left , right)
	
	if Input.is_action_just_pressed(shoot_action):
		weapon.fire()
	
	if get_slide_count() > 0:
		var collided = get_slide_collision(0)
		print("player " , id , " collided with something from " , collided.get_position())
	
	movement = move_and_slide(movement)
