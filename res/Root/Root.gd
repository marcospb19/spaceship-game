extends Node2D

var players_quantity = 0
var current_scene = null

func _ready():
	_set_current_scene("res://GUI/Menus/StartScreen.tscn")

func _process(delta):
	# Exit the game with ESC
	if Input.is_key_pressed(KEY_ESCAPE):
		self.get_tree().quit()

func set_players_quantity(quantity=1):
	players_quantity += quantity
	
func get_players_quantity():
	return players_quantity

func _set_current_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	if current_scene:
		current_scene.queue_free()
	
	var scene = ResourceLoader.load(path)
	
	current_scene = scene.instance()
	
	get_tree().get_root().add_child(current_scene)
	
	get_tree().set_current_scene(current_scene)
