extends Node2D

# Player 1 and 2 configuration
const controls := [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT],
	[KEY_W  , KEY_A    , KEY_S    , KEY_D    ]
]
var can_spawn          := [true  , true]
var spawn_key          := [controls[0][0] , controls[1][0]]
var fire_actions       := ["p1_fire" , "p2_fire"]
var rotation_inertia   := [false , true]
var starting_positions := [Vector2(300 , 300) , Vector2(500 , 300)]
const player_paint_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipPaint.tres"),
	preload("res://Shaders/Players/Player2SpaceshipPaint.tres")
]
const player_light_pads_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipLightPads.tres"),
	preload("res://Shaders/Players/Player2SpaceshipLightPads.tres")
]

const player_resource := preload("res://Player/Player.tscn")
const enemy_resource := preload("res://Enemy/Enemy.tscn")

onready var players_node := $Players
onready var enemies_node := $Enemies
onready var projectiles_node := $Projectiles

func get_players():
	return players_node.get_children()

func get_enemies():
	return enemies_node.get_children()

func get_projectiles():
	return enemies_node.get_children()

func get_quantity_of_players():
	var quantity = 0
	for can in can_spawn:
		if not can:
			quantity += 1
	return quantity

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		_spawn_enemy(event.position)

func _spawn_enemy(position: Vector2 , angle := 0.0):
	var enemy = enemy_resource.instance()
	enemy.set_starting_position(position , angle)
	enemies_node.add_child(enemy)
	print("Enemy Spawned At: " , position)

func _spawn_player(i: int):
	var player = player_resource.instance()
	player.set_controls(controls[i] , fire_actions[i] , rotation_inertia[i])
	player.id = i
	player.group = 1
	player.set_starting_position(starting_positions[i] , -90)
	player.get_node("Sprites/LightPads").material = player_light_pads_shaders[i]
	player.get_node("Sprites/ShipSprite").material = player_paint_shaders[i]
	can_spawn[i] = false
	
	player.get_node("Weapon").setup_weapon(projectiles_node , player.group)
	players_node.add_child(player)

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		for player in get_players():
			player.reset_position()
	
	# If should spawn player [i]
	for i in range(2):
		if can_spawn[i] and Input.is_key_pressed(spawn_key[i]):
			# Spawn
			_spawn_player(i)
