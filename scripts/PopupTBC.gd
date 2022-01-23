extends CenterContainer

var sudah_muncul = false

onready var tween = $Tween

func _ready():
	pass
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -600, 0, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")

func _on_btn_restart_pressed():
	get_parent().get_node("anim").play("to_black")
#	$UI/anim.play("to_black")
	var _err = get_tree().reload_current_scene()


func _on_btn_keluar_pressed():
	get_parent().get_node("anim").play("to_black")
#	$UI/anim.play("to_black")
	var _err = get_tree().change_scene("res://scenes/levels/menu.tscn")


func _on_level1_player_level_tbc():
	if not sudah_muncul:
		sudah_muncul = true
	muncul() 


func _on_level2_player_level_tbc():
	if not sudah_muncul:
		sudah_muncul = true
	muncul()


func _on_level3_player_level_tbc():
	if not sudah_muncul:
		sudah_muncul = true
	muncul()
