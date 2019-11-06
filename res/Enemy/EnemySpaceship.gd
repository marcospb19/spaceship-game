extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

onready var weapon := preload("res://Weapons/Weapon.gd").new()
onready var root   := get_node("../../") # Get the level

var up: bool
var left: bool
var down: bool
var right: bool

func _aim_to_position(target_position: Vector2):
	var normalized_position: Vector2 = (position - target_position).normalized()
	var angle = atan2(normalized_position.y , normalized_position.x)
	set_rotation_degrees(rad2deg(angle) - 90)

func _track_nearest_player():
	var players: Array = root.get_players()
	if len(players) == 0:
		return
	var nearest_player = players[0]
	
	if len(players) == 2:
		if (players[1].position - self.position).length() < (nearest_player.position - self.position).length():
			nearest_player = players[1]
	_aim_to_position(nearest_player.position)

func _physics_process(delta):
	var up    = false
	var left  = false
	var down  = false
	var right = false
	
	_handle_sprites(up , left , down , right)
	_handle_movement(up , down)
	_handle_rotation(left , right)
	
	if false:
		weapon.fire()
	
	_track_nearest_player()
	movement = move_and_slide(movement)
