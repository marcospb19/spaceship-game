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

onready var players_node      := $Background/VBoxContainer/HBoxContainer/Players
onready var switch_mode_label := $Background/VBoxContainer/VBoxContainer/TabLabel

func get_players():
	return players_node.get_children()

func get_quantity_of_players():
	var quantity = 0
	for can in can_spawn:
		if not can:
			quantity += 1
	return quantity

func _add_player(player):
	players_node.add_child(player)

func _spawn_player(i: int) -> KinematicBody2D:
	var player = player_resource.instance()
	player.set_controls(controls[i] , spawn_key[i])
	player.id = i
	player.set_starting_position(starting_positions[i])
	can_spawn[i] = false
	
	return player

func _process(delta):
	if get_quantity_of_players() == 2:
		switch_mode_label.visible = true
	
	# If should spawn player [i]
	for i in range(2):
		if can_spawn[i] and Input.is_action_just_pressed(spawn_key[i]):
			# Spawn
			_add_player(_spawn_player(i))