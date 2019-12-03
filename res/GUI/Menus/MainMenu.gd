extends Control

func _on_Button1_pressed():
	Root.change_game_scene("res://Levels/PlayerSelection.tscn" , "Campanha")

func _on_Button2_pressed():
	Root.change_game_scene("res://Levels/PlayerSelection.tscn" , "Arena")
