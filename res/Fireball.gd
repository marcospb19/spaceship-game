extends "res://Vehicles/VehicleBase.gd"

func _ready():
	set_starting_position(Vector2(0 , 0) , -30)

onready var sprite := $Sprite
func _rotate_sprites():
	sprite.rotate(deg2rad(5))

func set_starting_position(position , angle := 0.0):
	.set_starting_position(position , angle)
	movement = Vector2(sin(angle) , cos(angle)) * 80

func _physics_process(delta: float) -> void:
	_rotate_sprites()
	move_and_slide(movement)
