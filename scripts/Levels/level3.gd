extends "res://scripts/level.gd"


export(int) var next_level = 4
export(int) var buah = 4


func add_buah():
	MusicController.play_suara_buah()
	buah_added += 1
	print("Buah : " + str(buah_added))
	
	if buah_added == buah:
		var file = File.new()
		if file.file_exists("res://scenes/levels/level" + str(next_level) +".tscn"):
			MusicController.play_suara_level_complete()
			var _err = get_tree().change_scene("res://scenes/levels/level" + str(next_level) +".tscn")
			print("Pindah ke level " + str(next_level))
		else:
			MusicController.play_suara_game_over()
			print("Game Over")
