extends Camera2D

var player_positions = []
var smoothness := 0.03

# Just to make sure, but you should do this on the editor instead
func _ready():
	self.current = true

func _physics_process(delta: float) -> void:
	var player_list = get_parent().get_players()
	var player_quantity = len(player_list)
	if player_quantity == 0:
		return # Stand still
	
	var previous_position = get_position()
	
	var media_aritmetica = Vector2(0 , 0)
	for player in player_list:
		media_aritmetica += player.get_position()
	
	media_aritmetica /= player_quantity
	print(media_aritmetica)
	
	set_position(previous_position * (1 - smoothness) + media_aritmetica * smoothness)
