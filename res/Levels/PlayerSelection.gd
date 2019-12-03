extends Control

const controls := [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT],
	[KEY_W  , KEY_A    , KEY_S    , KEY_D  ]
]
var can_spawn        := [true  , true]
var rotation_inertia := [false , true]

var spawn_key        := ["p1_fire" , "p2_fire"]
var starting_positions := [Vector2(150 , 175) , Vector2(600 , 175)]

const player_resource  := preload("res://Player/Player.tscn")

const player_paint_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipPaint.tres"),
	preload("res://Shaders/Players/Player2SpaceshipPaint.tres")
]
const player_light_pads_shaders := [
	preload("res://Shaders/Players/Player1SpaceshipLightPads.tres"),
	preload("res://Shaders/Players/Player2SpaceshipLightPads.tres")
]

onready var players_node := $Background/VBoxContainer/HBoxContainer/Players
onready var enter_label  := $Background/VBoxContainer/VBoxContainer/EnterLabel

func get_players():
	return players_node.get_children()

func get_quantity_of_players():
	var quantity = 0
	for can in can_spawn:
		if not can:
			quantity += 1
	return quantity

func _spawn_player(i: int):
	var player = player_resource.instance()
	player.set_controls(controls[i] , "" , false)
	player.id = i
	player.group = 1
	player.set_starting_position(starting_positions[i] , -90)
	player.get_node("Sprites/LightPads").material = player_light_pads_shaders[i]
	player.get_node("Sprites/ShipSprite").material = player_paint_shaders[i]
	can_spawn[i] = false
	players_node.add_child(player)


var campanha := false
var arena    := false

func _process(delta):
	
	for player in get_players():
		player.reset_position()

	if get_quantity_of_players() > 0:
		print(arena)
		print(campanha)
		print(get_quantity_of_players())
		
		if arena and get_quantity_of_players() > 1:
			enter_label.visible = true
		elif campanha:
			enter_label.visible = true
		
		# Aqui troca envia os caras pra nova fase !!!!!
		if Input.is_key_pressed(KEY_ENTER) and enter_label.visible == true:

			Root.players_quantity = get_quantity_of_players()
			print("Root.players_quantity = " , Root.players_quantity)

			if campanha:
				Root.change_game_scene("res://Levels/Level1/Level1.tscn")
			elif arena:
				Root.change_game_scene("res://Levels/LevelArena/LevelArena.tscn")

	else:
		enter_label.visible = false

	# If should spawn player [i]
	for i in range(2):
		if can_spawn[i] and Input.is_action_just_pressed(spawn_key[i]):
			# Spawn
			_spawn_player(i)
