extends Node


var music_hutan = load("res://assets/audio/theme-2.ogg")


func _ready():
	pass # Replace with function body.
	

func play_music_hutan():
	$Music.stream = music_hutan
	$Music.play()
