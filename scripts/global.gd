extends Node

const FILE_NAME = "user://savegame.save"
const default_level = -1
const default_retry = 0 

var level = -1
var retry = 0

var loaded = {}

func save_dictionary(is_new = false) -> Dictionary:
	var save_dict = {
		"level" : default_level if is_new else level , 
		"retry" : default_retry if is_new else retry
	}
	return save_dict

func add_level() -> void:
	level += 1
	save_game()


func add_restart() -> void:
	retry += 1
	save_game()


func save_exist() -> bool:
	var file = File.new()
	return file.file_exists(FILE_NAME)


func save_game(is_new:bool = false) -> void:
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	var dic = save_dictionary(is_new)
	file.store_line(to_json(dic))
	file.close()
	

func load_game():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			loaded = data
			level = loaded["level"]
			retry = loaded["retry"]
		else:
			printerr("Data Corrupted!")
	else:
		printerr("Tidak ada save game!")


func get_level() -> int:
	load_game()
	return loaded["level"]
	
	
func get_retry() -> int:
	load_game()
	return loaded["retry"]
	
