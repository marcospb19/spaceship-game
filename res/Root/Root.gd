extends Node2D

# the list corresponds to   [Player 1 , Player 2] ...
# Check if the spaceship isn't already instanced
var can_spawn             = [true , true]
# Key to press to instance spaceship [i]
const spawn_keys          = [KEY_W , KEY_UP]
# Inertia enabled
const ships_with_inertia  = [false , true ]
# Controlls for each ship
const map_keys = [
	[KEY_UP , KEY_LEFT , KEY_DOWN , KEY_RIGHT], # Player 1
	[KEY_W , KEY_A , KEY_S , KEY_D]             # Player 2
]


var max_quantity_of_spaceships = 2

# Position to spawn each ship
const spawn_placement = [Vector2(200 , 200) , Vector2(400 , 200)]

# To instance spaceships
const spaceship_prototype = preload("res://Spaceship/Spaceship.tscn")


func _process(delta):
	
	# Exit the game with ESC
	if Input.is_key_pressed(KEY_ESCAPE):
		self.get_tree().quit()

	if Input.is_key_pressed(KEY_R):
		for node in self.get_children():
			print(node.name)


	# Check for creating each spaceship
	for i in range(max_quantity_of_spaceships):
		# If can spawn the spaceship [i], check if it should be instanced
		if can_spawn[i]:
			#if Input.is_key_pressed(spawn_keys[i]):
			if true:
				
				# Instance it
				var node = spaceship_prototype.instance()
				node.set_position(spawn_placement[i])
				var controller = node.get_node("Controller")
				
				print(controller)
				controller.key_up    = map_keys[i][0]
				controller.key_left  = map_keys[i][1]
				controller.key_down  = map_keys[i][2]
				controller.key_right = map_keys[i][3]
				
				controller.is_rotation_inertia_enabled = ships_with_inertia[i]
				
				self.add_child(node)
				
				# Don't let it spawn again
				can_spawn[i] = false
