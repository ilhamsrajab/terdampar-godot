extends TextureProgress


func _ready():
	if value == 100:
		stretch_margin_left = 100 
		stretch_margin_right = 100
	elif value < 50:
		stretch_margin_left = 0
		stretch_margin_right = 100
