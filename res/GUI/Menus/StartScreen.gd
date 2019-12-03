extends Control

func is_mouse_pressed(event: InputEvent) -> bool:
	return event is InputEventMouseButton and event.is_pressed()

func is_enter_pressed() -> bool:
	return Input.is_action_pressed("ui_accept")

func _input(event: InputEvent):
	if is_mouse_pressed(event) or is_enter_pressed():
		Root._set_current_scene('res://GUI/Menus/MainMenu.tscn')
