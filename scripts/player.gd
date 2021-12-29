extends StaticBody

var dir = Vector3.ZERO
var old_dir = Vector3.ZERO
var is_moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	dir = Vector3.ZERO
	
	if Input.is_action_just_pressed("ui_up"): dir = Vector3.BACK
	if Input.is_action_just_pressed("ui_down"): dir = Vector3.FORWARD
	if Input.is_action_just_pressed("ui_left"): dir = Vector3.RIGHT
	if Input.is_action_just_pressed("ui_right"): dir = Vector3.LEFT
	
	if dir != Vector3.ZERO and dir != old_dir:
		old_dir = dir
		$ray1.translation = old_dir * 2 + Vector3.UP * 2.5
	
	if dir != Vector3.ZERO:
		movement(dir)
		print(dir)

func movement(vec:Vector3):
	if is_moving == false:
		is_moving = true
		var a = translation
		var b = a + vec * 2
		
		$tw_m.interpolate_property(self, "translation", a, b, 0.1, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$tw_m.start()
		
		yield($tw_m, "tween_all_completed")
		is_moving = false
