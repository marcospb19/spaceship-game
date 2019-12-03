extends Control

onready var players_node  := $Background/VBoxContainer/HBoxContainer/Players
onready var enter_label   := $Background/VBoxContainer/VBoxContainer/EnterLabel

func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		Root.change_game_scene("res://GUI/Menus/MainMenu.tscn")
