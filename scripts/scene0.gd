extends Spatial

export(int) var next_level = 1
export(int) var apel = 1
var apel_added = 0 

var ketinggian_air = 1.5


# Called when the node enters the scene tree for the first time.
func _ready():
	var ratio = get_viewport().size.x / get_viewport().size.y
	var shader = $CanvasLayer/fade.material
	shader.set_shader_param("aspect_ratio", ratio)
	 
	$air.visible = true
	$CanvasLayer/fade.visible = true
	$CanvasLayer/anim.play("to_zero")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$air.translation.y = lerp($air.translation.y, ketinggian_air, 0.015)
	$kamera/Camera.rotation_degrees.z = lerp($kamera/Camera.rotation_degrees.z, 0.0, 0.15)


func _on_Timer_timeout():
	randomize()
	ketinggian_air = rand_range(2.0, 2.7)
	$Timer.wait_time = rand_range(0.1, 0.6)
	pass # Replace with function body.


func shake():
	$kamera/Camera.rotation_degrees.z = -3


func add_apel():
	apel_added += 1
	if apel_added == apel:
		var file = File.new()
		if file.file_exists("res://levels/scene" + str(next_level) +".tscn"):
			var _err = get_tree().change_scene("res://levels/scene" + str(next_level) +".tscn")
		else:
			print("Game Over")


func _on_btn_home_pressed():
	$CanvasLayer/anim.play("to_black")
	yield($CanvasLayer/anim, "animation_finished")
	var _err = get_tree().change_scene("res://levels/menu.tscn")


func _on_btn_retry_pressed():
	$CanvasLayer/anim.play("to_black")
	yield($CanvasLayer/anim, "animation_finished")
	var _err = get_tree().reload_current_scene()
