extends Spatial

#export(int) var next_level = 2
#export(int) var apel = 1

var buah_added = 0 

var ketinggian_air = 1.5

onready var health_bar = $UI/HealthBar/ProgressBar

signal player_menang()
signal player_mati()
signal player_level_tbc()

# Called when the node enters the scene tree for the first time.
func _ready():
	var ratio = get_viewport().size.x / get_viewport().size.y
	var shader = $UI/fade.material
	shader.set_shader_param("aspect_ratio", ratio)
	 
	health_bar.value = 100
	
	$Map/air.visible = true
	$UI/fade.visible = true
	$UI/anim.play("to_zero")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Map/air.translation.y = lerp($Map/air.translation.y, ketinggian_air, 0.015)
	$kamera/Camera.rotation_degrees.z = lerp($kamera/Camera.rotation_degrees.z, 0.0, 0.15)


func _on_Timer_timeout():
	randomize()
	ketinggian_air = rand_range(2.0, 2.7)
	$Map/Timer.wait_time = rand_range(0.1, 0.6)
	pass # Replace with function body.


func shake():
	$kamera/Camera.rotation_degrees.z = -3


func _on_player_player_health(value):
	health_bar.value = value


