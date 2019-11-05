extends KinematicBody2D


# Attributes of the Spaceship physics
#
# Spaceship's movement speed, respects inertia
var movement := Vector2(0 , 0)
# Rotation inertia option. Specified at instanciation
var is_rotation_inertia_enabled: bool = false
# Rotation inertia speed in radians, if inertia is enabled
var rotation_speed: float = 0
# Can change when ship is uncontrollable
var can_move: bool = true
# Current angle in radians, used to calculate boost direction
var current_angle: float = 0


# Speed Constants
#
# (Units per second)²
const BOOST_SPEED_CONSTANT: int = 10
# In radians
const ROTATION_SPEED_CONSTANT: float = deg2rad(2)
# In radians
const INERTIA_ROTATION_SPEED_CONSTANT: float = deg2rad(0.05)

# Control the propulsor sprites
func _handle_sprites(up , left , down , right) -> void:
	$Thrusters/MainThruster.set_visible(up)
	$Thrusters/ReverseThruster.set_visible(down)
	$Thrusters/LeftRotator.set_visible(right)
	$Thrusters/RightRotator.set_visible(left)

func _physics_process(delta):
	current_angle = deg2rad(self.get_rotation_degrees())

################# GUN
var can_shoot: bool = true
################# GUN


onready var weapon = "res://Spaceships/Weapon/Weapon.gd"

var shoot_action = "player1_fire"

# Using WASD to represent the control keys
# Control keys
var key_up: int
var key_left: int
var key_down: int
var key_right: int

# Called when instanciating
func set_controls(keys: Array) -> void:
	key_up    = keys[0]
	key_left  = keys[1]
	key_down  = keys[2]
	key_right = keys[3]

# Handle boost
func _handle_movement(up , down) -> void:
	# Main thrust
	if up:
		movement.x -= cos(current_angle) * BOOST_SPEED_CONSTANT
		movement.y -= sin(current_angle) * BOOST_SPEED_CONSTANT
	# Reverse thrust
	if down:
		movement.x += cos(current_angle) * BOOST_SPEED_CONSTANT / 2
		movement.y += sin(current_angle) * BOOST_SPEED_CONSTANT / 2

# Ship rotation
func _handle_rotation(left , right) -> void:
	# Rotation with inertia
	if is_rotation_inertia_enabled:
		if left:
			rotation_speed -= INERTIA_ROTATION_SPEED_CONSTANT
		if right:
			rotation_speed += INERTIA_ROTATION_SPEED_CONSTANT
		self.rotate(rotation_speed)
	# Flat rotation (without inertia)
	else:
		if left:
			self.rotate(-ROTATION_SPEED_CONSTANT)
		if right:
			self.rotate( ROTATION_SPEED_CONSTANT)


# Player physics process
func _physics_process(delta) -> void:

	# Receiving the player input
	var up    = Input.is_key_pressed(key_up)
	var left  = Input.is_key_pressed(key_left)
	var down  = Input.is_key_pressed(key_down)
	var right = Input.is_key_pressed(key_right)
	
	if can_move:
		_handle_sprites (up , left , down , right)
		_handle_movement(up , down)
		_handle_rotation(left , right)

	movement = move_and_slide(movement)





## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## DebugLevel.gd



extends Node2D


# Players configuration
#
# Each element of the lists correspond to a player configuration
# Example: var example_var = [Player 1 , Player 2...]
#
# Controls for each ship
const KEY_MAP = [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT], # Player 1, arrow keys
	[KEY_W  , KEY_A    , KEY_S    , KEY_D    ]  # Player 2, WASD
]
# Check if spaceship is already instanced
var can_spawn_player     = [true , true]
# Key to press to instance spaceship
const PLAYER_SPAWN_KEY   = [KEY_MAP[0][0] , KEY_MAP[1][0]]
# Inertia enabled
const PLAYER_HAS_INERTIA = [false , true]
# Position to spawn each ship
const SPAWN_PLACEMENT = [Vector2(300 , 300) , Vector2(600 , 300)]

# To instance players
onready var player_resource = preload("res://Spaceships/Player/Player.tscn")
onready var enemy_resource  = preload("res://Spaceships/Enemy/Enemy.tscn")
onready var players_node = $Players
onready var enemies_node = $Enemies


func spawn_enemy() -> void:
	var enemy = enemy_resource.instance()
	enemy.set_position(Vector2(300 , 300))
	enemies_node.add_child(enemy)

func get_players() -> Array:
	return players_node.get_children()

func get_enemies() -> Array:
	return enemies_node.get_children()


func _process(delta) -> void:

	if Input.is_action_just_pressed("ui_home"):
		spawn_enemy()
	
	# Exit the game with ESC
	if Input.is_key_pressed(KEY_ESCAPE):
		self.get_tree().quit()
	
	# Press R to reset ships position
	if Input.is_key_pressed(KEY_R):
		# For each player, reset the position
		for player in get_players():
			player.reset_position()
	
	# Check for creating each spaceship
	for i in range(2):
		# If can spawn the spaceship [i]
		if can_spawn_player[i]:
			# If spawn key is pressed for the [i] player
			if Input.is_key_pressed(PLAYER_SPAWN_KEY[i]):
				
				var player = player_resource.instance()

				player.set_controls(KEY_MAP[i])
				player.set_start_trajectory(SPAWN_PLACEMENT[i])
				player.is_rotation_inertia_enabled = PLAYER_HAS_INERTIA[i]
				
				players_node.add_child(player)
				
				can_spawn_player[i] = false # Mark as spawned
