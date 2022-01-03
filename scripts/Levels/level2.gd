extends "res://scripts/level.gd"


export(int) var next_level = 3
export(int) var apel = 2


func add_apel():
	apel_added += 1
	if apel_added == apel:
		var file = File.new()
		if file.file_exists("res://levels/level" + str(next_level) +".tscn"):
			var _err = get_tree().change_scene("res://levels/level" + str(next_level) +".tscn")
		else:
			print("Game Over")
