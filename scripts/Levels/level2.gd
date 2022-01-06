extends "res://scripts/level.gd"


export(int) var next_level = 3
export(int) var apel = 2


func add_apel():
	MusicController.play_suara_buah()
	apel_added += 1
	if apel_added == apel:
		var file = File.new()
		if file.file_exists("res://scenes/levels/level" + str(next_level) +".tscn"):
			MusicController.play_suara_level_complete()
			var _err = get_tree().change_scene("res://scenes/levels/level" + str(next_level) +".tscn")
		else:
			MusicController.play_suara_game_over()
			print("Game Over")
