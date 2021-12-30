extends Spatial

var loop = [
	Vector3(0, 0, 1),
	Vector3(0, 0, 1),
	Vector3(1, 0, 0),
	Vector3(1, 0, 0),
	Vector3(0, 0, -1),
	Vector3(0, 0, -1),
	Vector3(-1, 0, 0),
	Vector3(-1, 0, 0),
	Vector3(-1, 0, 0),
	Vector3(-1, 0, 0),
	Vector3(0, 0, -1),
	Vector3(0, 0, -1),
	Vector3(1, 0, 0),
	Vector3(1, 0, 0),
	Vector3(0, 0, 1),
	Vector3(0, 0, 1),
]

var id = 0
var ketinggian_air = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	$air.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$air.translation.y = lerp($air.translation.y, ketinggian_air, 0.15)
	$kamera/Camera.rotation_degrees.z = lerp($kamera/Camera.rotation_degrees.z, 0.0, 0.15)

func _on_Timer_timeout():
	randomize()
	ketinggian_air = rand_range(2.0, 2.7)
	$Timer.wait_time = rand_range(0.1, 0.6)
	pass # Replace with function body.

func shake():
	$kamera/Camera.rotation_degrees.z = -3

func _on_btn_new_pressed():
	var _err = get_tree().change_scene("res://levels/scene0.tscn")

func _on_btn_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_Timer2_timeout():
	$player.external_dir(loop[id])
	id += 1
	if id == loop.size():
		id = 0
