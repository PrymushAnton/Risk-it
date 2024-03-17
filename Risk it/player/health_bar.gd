extends TextureProgressBar

var player


func _ready():
	player = $"../../../.."


func _process(delta):
	value = player.current_hp * 100 / player.endurance

