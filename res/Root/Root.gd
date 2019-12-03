extends Node2D

var winner_player = null
var current_scene: Node = null
var should_spawn_players := [false , false]
var who_won: int


func _ready():
	# Current Scene começa com é o StartScreen, que é a cena default
	current_scene = get_tree().get_root().get_child(1)
	print("--------------------   Start tree   --------------------")
	get_tree().get_root().print_tree_pretty()

func _process(delta):
	# Exit the game with ESC
	if Input.is_key_pressed(KEY_ESCAPE):
		self.get_tree().quit()

func change_game_scene(path , custom_config := ""):
	call_deferred("_deferred_goto_scene", path , custom_config)

func _deferred_goto_scene(path , custom_config := ""):
	if current_scene:
		# Deattach child and free it's node stuff
		current_scene.queue_free()
	
	current_scene = ResourceLoader.load(path).instance()
	get_tree().get_root().add_child(current_scene)
	
	# Se foi passada alguma configuração para a mudança de cena, tratar
	if custom_config != "":
		current_scene.campanha = true
		if custom_config == "Campanha":
			current_scene.campanha = true
		elif custom_config == "Arena":
			current_scene.campanha = false
			current_scene.arena = true
		
		print(current_scene.campanha == true)
	
	print("---------------------   New tree   ---------------------")
	get_tree().get_root().print_tree_pretty()
