extends CenterContainer

onready var tween = $Tween

func _ready():
	pass
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -1080, 0, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")



func _on_btn_next_pressed():
	tween.interpolate_property(self, "rect_position:y", 0, -1080, 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.start()
	
	yield(tween, "tween_all_completed")


func _on_menu_btn_info():
	muncul()
