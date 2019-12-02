extends "res://Vehicles/Spaceships/SpaceshipBase.gd"

onready var weapon := preload("res://Weapons/Weapon.gd").new()
onready var level  := get_node("../../") # Get the level
# onready var enemy_material := preload("res://Shaders/RedSpaceship.tres")

func _ready():
	# $Sprites/ShipSprite.material = enemy_material
	$Sprites/LightPads.material = null

func _aim_to_position(target_position: Vector2):
	var normalized_position: Vector2 = (position - target_position).normalized()
	var angle = atan2(normalized_position.y , normalized_position.x)
	set_rotation_degrees(rad2deg(angle) + 45)

func _track_nearest_player():
	var players: Array = level.get_players()
	if len(players) == 0:
		return
	var nearest_player = players[0]
	
	if len(players) == 2:
		if (players[1].position - self.position).length() < (nearest_player.position - self.position).length():
			nearest_player = players[1]
	_aim_to_position(nearest_player.position)


var movement_frame_count := 1
var fire_frame_count := 1

func _physics_process(delta):
	left  = false
	down  = false
	right = false
	
	movement_frame_count += 1
	movement_frame_count = movement_frame_count % 50
	if movement_frame_count >= 45:
		up = true
	else:
		up = false
	
	fire_frame_count += 1
	fire_frame_count = fire_frame_count % 200
	#if fire_frame_count == 0:
		#weapon.fire(get_position() , rad2deg(current_angle) , Vector2)
	
	_handle_sprites(up , left , down , right)
	_handle_movement(up , down , delta)
	_handle_rotation(left , right)
	
	_track_nearest_player()
	movement = move_and_slide(movement)
