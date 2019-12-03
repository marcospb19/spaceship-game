extends Camera2D

var movement_smoothness := 0.05
var zoom_smoothness := 0.5
var min_zoom := 1.2

func _handle_camera_position(positions: Array):
	if len(positions) == 0:
		return

	var media_aritmetica = Vector2(0 , 0)
	for pos in positions:
		media_aritmetica += pos
	media_aritmetica /= len(positions)

	# Moving the camera smoothly
	set_position(get_position() * (1 - movement_smoothness) + media_aritmetica * movement_smoothness)

func _handle_camera_zoom(positions: Array):
	if len(positions) < 2:
		set_zoom(Vector2(min_zoom , min_zoom))
		return
	
	var min_values = positions[0] # Vector2
	var max_values = positions[0] # Vector2
	
	for pos in positions:
		min_values.x = min(pos.x , min_values.x)
		min_values.y = min(pos.y , min_values.y)
		max_values.x = max(pos.x , max_values.x)
		max_values.y = max(pos.y , max_values.y)
	
	var difference = max_values - min_values
	var zoom_factor = min_zoom
	zoom_factor = max(difference.x / 1000, zoom_factor)
	zoom_factor = max(difference.y / 600 , zoom_factor)
	set_zoom(get_zoom() * (1 - zoom_smoothness) + Vector2(zoom_factor , zoom_factor) * zoom_smoothness)


func _physics_process(delta: float) -> void:
	var player_pos = []
	for player in get_parent().get_players():
		player_pos.append(player.get_position())
		
	var enemy_pos = []
	for enemy in get_parent().get_enemies():
		enemy_pos.append(enemy.get_position())

	_handle_camera_position(player_pos)
	_handle_camera_zoom(player_pos + enemy_pos)
