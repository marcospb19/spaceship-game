extends Control

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() or Input.is_action_pressed("ui_accept"):
		Root.change_game_scene('res://GUI/Menus/MainMenu.tscn')
