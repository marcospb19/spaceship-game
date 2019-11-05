extends Node2D

func _process(delta):
	# Exit the game with ESC
	if Input.is_key_pressed(KEY_ESCAPE):
		self.get_tree().quit()
