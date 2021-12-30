extends StaticBody

var dir = Vector3.ZERO
var is_moving = false

func _process(_delta):
	if dir != Vector3.ZERO:
		movement(dir)

func set_dir(vec:Vector3):
	dir = vec

func movement(vec:Vector3):
	if is_moving == false:
		is_moving = true
		var a = translation
		var b = a + vec * 2
		
		$tw_m.interpolate_property(self, "translation", a, b, 0.01, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$tw_m.start()
		
		yield($tw_m, "tween_all_completed")
		dir = Vector3.ZERO
		
		if $ray_down.is_colliding() == false:
			var c = b + Vector3.DOWN * 2
			$tw_m.interpolate_property(self, "translation", b, c, 0.1, Tween.TRANS_EXPO, Tween.EASE_OUT)
			$tw_m.start()
			$MeshInstance.translation.y += 0.4
		
		is_moving = false
