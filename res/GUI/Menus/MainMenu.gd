extends Control

func _on_Button1_pressed() -> void:
	get_tree().change_scene('res://Levels/Campaign/CampaignStart.tscn')


func _on_Button2_pressed() -> void:
	get_tree().change_scene('res://Levels/Arena/ArenaStart.tscn')