extends CenterContainer

onready var tween = $Tween

func _ready():
	pass
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -600, 0, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")


func _on_btn_restart_pressed():
	get_parent().get_parent().get_node("anim").play("to_black")
#	$UI/anim.play("to_black")
	var _err = get_tree().reload_current_scene()


func _on_level_player_menang():
	muncul() 
