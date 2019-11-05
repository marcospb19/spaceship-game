extends Node2D

const controls := [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT],
	[KEY_W  , KEY_A    , KEY_S    , KEY_D    ]
]
var can_spawn        := [true  , true]
var rotation_inertia := [false , true]

var spawn_key        := [controls[0][0] , controls[1][0]]
var fire_actions     := ["p1_fire" , "p2_fire"]

var starting_positions := [Vector2(300 , 300) , Vector2(500 , 300)]

const player_resource := preload("res://Player/Player.tscn")
const enemy_resource := preload("res://Enemy/Enemy.tscn")

onready var players_node := $Players

func get_players():
	return players_node.get_children()

func _add_player(player):
	players_node.add_child(player)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		_spawn_enemy(event.position)

func _spawn_enemy(position: Vector2 , angle := 0.0):
	print("Enemy Spawned At: " , position)

func _spawn_player(i: int) -> KinematicBody2D:
	var player = player_resource.instance()
	
	player.controls(controls[i] , fire_actions[i] , rotation_inertia[i])
	player.set_starting_position(starting_positions[i])
	can_spawn[i] = false
	
	return player

func _process(delta):
	
	# If should spawn player [i]
	for i in range(2):
		if can_spawn[i] and Input.is_key_pressed(spawn_key[i]):
			# Spawn
			_add_player(_spawn_player(i))
