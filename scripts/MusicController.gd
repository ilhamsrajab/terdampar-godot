extends Node


var music_hutan = load("res://assets/audio/theme-2.ogg")
var music_pantai = load("res://assets/audio/theme-2.ogg")

var suara_langkah = load("res://assets/audio/Sound Effect/Langkah.ogg")
var suara_langkah_alt = load("res://assets/audio/Sound Effect/langkah-alt.mp3")
var suara_block = load("res://assets/audio/Sound Effect/block.wav")
var suara_buah = load("res://assets/audio/Sound Effect/Buah.wav")
var suara_buah_alt = load("res://assets/audio/Sound Effect/buah-alt.wav")
var suara_jatuh_air = load("res://assets/audio/Sound Effect/jatuh-air.mp3")
var suara_level_complete = load("res://assets/audio/Sound Effect/Level Complete.wav")
var suara_nabrak = load("res://assets/audio/Sound Effect/Nabrak.wav")
var suara_pindah_scene = load("res://assets/audio/Sound Effect/Pindah Scene.wav")
var suara_game_over = load("res://assets/audio/Sound Effect/Game Over.wav")

func _ready():
	pass # Replace with function body.
	

func play_music_hutan():
	$music.stream = music_hutan
	$music.play()


func play_music_pantai():
	$music.stream = music_pantai
	$music.play()
	
	
func play_suara_langkah():
	$langkah.stream = suara_langkah
	$langkah.play()


func play_suara_langkah_alt():
	$langkah.stream = suara_langkah_alt
	$langkah.play()


func play_suara_buah():
	$effect.stream = suara_buah_alt
	$effect.play()


func play_suara_block():
	$effect.stream = suara_block
	$effect.play()


func play_suara_jatuh_air():
	$level.stream = suara_jatuh_air
	$level.play()


func play_suara_level_complete():
	$level.stream = suara_level_complete
	$level.play()


func play_suara_nabrak():
	$effect.stream = suara_nabrak
	$effect.play()

	
func play_suara_pindah_scene():
	$level.stream = suara_pindah_scene
	$level.play()


func play_suara_game_over():
	$effect.stream = suara_game_over
	$effect.play()

