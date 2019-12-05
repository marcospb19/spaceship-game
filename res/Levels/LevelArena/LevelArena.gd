extends Node2D

# Player 1 and 2 configuration
const controls := [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT],
	[KEY_W  , KEY_A    , KEY_S    , KEY_D    ]
]
var can_spawn          := [true  , true]
var fire_actions       := ["p1_fire" , "p2_fire"]
var rotation_inertia   := [false , false]
var starting_positions := [Vector2(2000 , 2000) , Vector2(2500 , 2000)]
const player_paint_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipPaint.tres"),
	preload("res://Shaders/Players/Player2SpaceshipPaint.tres")
]
const player_light_pads_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipLightPads.tres"),
	preload("res://Shaders/Players/Player2SpaceshipLightPads.tres")
]

const player_resource := preload("res://Player/Player.tscn")

onready var players_node := $Players
onready var projectiles_node := $Projectiles

func get_players():
	return players_node.get_children()

func get_projectiles():
	return projectiles_node.get_children()

func get_quantity_of_players():
	var quantity = 0
	for can in can_spawn:
		if not can:
			quantity += 1
	return quantity

func _ready():
	print("LevelArena.gd")
	for i in range(2):
		_spawn_player(i)
	$Camera2D.first_camera_setup(get_players())

func _spawn_player(i: int):
	var player = player_resource.instance()
	player.set_controls(controls[i] , fire_actions[i] , rotation_inertia[i])
	player.id = i
	player.group = i
	player.set_starting_position(starting_positions[i] , -90)
	player.get_node("Sprites/LightPads").material = player_light_pads_shaders[i]
	player.get_node("Sprites/ShipSprite").material = player_paint_shaders[i]
	can_spawn[i] = false
	
	player.get_node("Weapon").setup_weapon(projectiles_node , player.group)
	players_node.add_child(player)

onready var health_bars := [get_node("Control/HealthBar1") , get_node("Control/HealthBar2")]

func _process(delta):
	for player in get_players():
		health_bars[player.id].set_value(player.HP)
	
		if player.HP == 0:
			Root.who_won = player.id
			Root.change_game_scene("res://Levels/Victory/Victory.tscn")
		
	if Input.is_key_pressed(KEY_R):
		for player in get_players():
			player.reset_position()
