extends "res://Vehicles/VehicleBase.gd"

const SPEED := 320
onready var sprite := $Sprite

func _self_destroy():
	queue_free()

func _rotate_sprites():
	sprite.rotate(deg2rad(5))

func set_projectile_trajectory(position: Vector2 , angle: float , parent_movement: Vector2):
	.set_starting_position(position , angle)
	reset_position()

	var radians = deg2rad(angle)
	movement = Vector2(cos(radians) , sin(radians))
	parent_movement = parent_movement.project(movement)

	if parent_movement.sign().x != movement.sign().x:
		parent_movement.x = 0 

	if parent_movement.sign().y != movement.sign().y:
		parent_movement.y = 0 

	var projectile_speed = max(parent_movement.length() + 95 , SPEED)
	movement *= projectile_speed

# IMPLEMENTATION OF VIRTUAL FUNCTION
func check_collisions(collision_object: KinematicCollision2D):
	if collision_object == null:
		return
	var collider = collision_object.collider
	
	if not collider.has_method("check_collisions"):
		print("Colidiu com alguém que não esperava-se")
		return
	
	if collider.has_method("set_controls"):
		collider.HP -= 20
		collider.check_collisions(collision_object)
		
	if collider.group == group:
		print("Colisão amiga")
	else:
		print("Colisão inimiga")
	_self_destroy()


func _physics_process(delta: float):
	_rotate_sprites()
	_handle_movement(false , false , delta) # Don't accelerate
	var collision = move_and_collide(movement * delta)
	check_collisions(collision)
