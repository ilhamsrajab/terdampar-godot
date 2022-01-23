extends "res://scripts/level.gd"

export(int) var level = 6
export(int) var buah = 5

onready var buah_bar = $UI/BuahBar/label_buah
onready var angka_level = $UI/Button/label_level

onready var player = $player

func _ready():
	angka_level.text = "Level - " + str(level)


func add_buah():
	MusicController.play_suara_buah()
	buah_added += 1
	buah_bar.text = "Buah : " + str(buah_added)
	print("Buah : " + str(buah_added))
	
	player.health += 15
	emit_signal("player_health", (float(player.health) / float(player.health_maks)) * 100)

	if buah_added == buah:
		var file = File.new()
		if file.file_exists("res://scenes/levels/level" + str(level + 1) +".tscn"):
			
			MusicController.play_suara_level_complete()
			print("Pindah ke level " + str(level + 1))
			
			emit_signal("player_menang")
			
		else:
			MusicController.play_suara_game_over()
			print("Game Over")
			
			emit_signal("player_level_tbc")


func _on_btn_next_pressed():
	var _err = get_tree().change_scene("res://scenes/levels/level" + str(level + 1) +".tscn")


func _on_btn_home_pressed():
	$UI/anim.play("to_black")
	yield($UI/anim, "animation_finished")
	var _err = get_tree().change_scene("res://scenes/levels/menu.tscn")


func _on_btn_retry_pressed():
	$UI/anim.play("to_black")
	yield($UI/anim, "animation_finished")
	var _err = get_tree().reload_current_scene()
