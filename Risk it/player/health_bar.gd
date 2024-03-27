extends TextureProgressBar

var player


func _ready():
	player = $"../../../.."
	max_value = player.endurance


func _process(delta):
	max_value = player.endurance
	value = player.current_hp
# player.current_hp * 100 / player.endurance
