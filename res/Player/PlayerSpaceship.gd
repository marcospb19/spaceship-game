extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

var key_up: int
var key_left: int
var key_down: int
var key_right: int
var shoot_action: String
# warning-ignore:unused_class_variable
var shoot_delay := 1.1
var id: int # Number of the player

onready var weapon = $Weapon


func set_controls(keys: Array , action: String , rotation_inertia: bool):
	key_up    = keys[0]
	key_left  = keys[1]
	key_down  = keys[2]
	key_right = keys[3]
	is_rotation_inertia_enabled = rotation_inertia
	shoot_action = action

func _handle_weapon(delta: float):
	if Input.is_action_just_pressed(shoot_action):
		weapon.fire(get_position() , current_angle , movement , delta)

# IMPLEMENTATION OF VIRTUAL FUNCTION
func check_collisions(collision_object: KinematicCollision2D):
	if collision_object == null:
		return
	var collider = collision_object.collider
	
	if not collider.has_method("check_collisions"):
		repel(collider , 0.9)
		return
	elif group == collider.group:
		repel(collider , 0.9)
		collider.repel(self , 0.9)
		print("Colisão amiga")
	else:
		print("Colisão inimiga")
		print("Decrease HP")

func _physics_process(delta):
	up    = Input.is_key_pressed(key_up)
	left  = Input.is_key_pressed(key_left)
	down  = Input.is_key_pressed(key_down)
	right = Input.is_key_pressed(key_right)
	
	_handle_sprites(up , left , down , right)
	_handle_rotation(left , right)
	_handle_weapon(delta)
	
	var collision = _handle_movement(up , down , delta)
	check_collisions(collision)
