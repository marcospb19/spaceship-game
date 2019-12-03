extends Control

func _on_Button1_pressed():
	Root._set_current_scene("res://Levels/Arena/ArenaStart.tscn")

func _on_Button2_pressed():
	get_tree().change_scene('res://Levels/Arena/ArenaStart.tscn')
