extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

var key_up: int
var key_left: int
var key_down: int
var key_right: int
var shoot_action: String
var id: int
# warning-ignore:unused_class_variable
var shoot_delay := 1.1

onready var weapon = $Weapon

func set_controls(keys: Array , action: String , rotation_inertia: bool):
	key_up    = keys[0]
	key_left  = keys[1]
	key_down  = keys[2]
	key_right = keys[3]
	is_rotation_inertia_enabled = rotation_inertia
	shoot_action = action

func _handle_weapon():
	if Input.is_action_just_pressed(shoot_action):
		weapon.fire(get_position() , current_angle , movement)

func _ready():
	group = id
	
# IMPLEMENTATION OF VIRTUAL FUNCTION
func check_collisions(collision_object: KinematicCollision2D):
	var collider = collision_object.collider
	
	if not collision_object.has_method("check_collisions"):
		print("Colidiu com alguém que não esperava-se")
		return
	
	if collision_object.group == id:
		print("Colisão amiga")
	else:
		print("Colisão inimiga")

func _physics_process(delta):
	up    = Input.is_key_pressed(key_up)
	left  = Input.is_key_pressed(key_left)
	down  = Input.is_key_pressed(key_down)
	right = Input.is_key_pressed(key_right)
	
	_handle_sprites(up , left , down , right)
	_handle_rotation(left , right)
# warning-ignore:return_value_discarded
	_handle_movement(up , down , delta)
	_handle_weapon()
