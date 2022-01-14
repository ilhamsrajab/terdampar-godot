extends "res://scripts/level.gd"


export(int) var next_level = 2
export(int) var buah = 1

onready var buah_bar = $UI/BuahBar/label_buah


func add_buah():
	MusicController.play_suara_buah()
	buah_added += 1
	buah_bar.text = str(buah_added)
	print("Buah : " + str(buah_added))
	
	
	if buah_added == buah:
		var file = File.new()
		if file.file_exists("res://scenes/levels/level" + str(next_level) +".tscn"):
			
			MusicController.play_suara_level_complete()
			print("Pindah ke level " + str(next_level))
			
			emit_signal("player_menang")
			
		else:
			MusicController.play_suara_game_over()
			print("Game Over")

func _on_btn_next_pressed():
	var _err = get_tree().change_scene("res://scenes/levels/level" + str(next_level) +".tscn")
	
