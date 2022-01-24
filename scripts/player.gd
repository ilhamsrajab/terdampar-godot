extends StaticBody

var ext_dir = Vector3.ZERO
var dir = Vector3.ZERO
var old_dir = Vector3.ZERO
var pos1 = Vector2.ZERO

var is_moving = false
var is_rotating = false
var sudah_mati = false

var is_wall1 = false
var is_push1 = false
var is_wall2 = false
var is_push2 = false
var is_wall3 = false
var is_push3 = false

var rot_y = 0
var old_rot_y = 0

export(int) var health_maks = 200
export(int) var health = 200

# signal player_health(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true
	var _shader = $fade/fade.material
	$fade/fade.visible = true
	$fade/anim.play("to_zero")
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.pressed:
			pos1 = event.position
		else: 
			calcul_swipe(event.position)
			pass


func calcul_swipe(pos2:Vector2):
	var pos = pos2 - pos1
	
	if pos.length() > 100:
		var a = rad2deg(pos.angle()) + 180
		var i = int(a / 90)
		
		match i:
			0:self.external_dir(Vector3.BACK)
			1:self.external_dir(Vector3.LEFT)
			2:self.external_dir(Vector3.FORWARD)
			3:self.external_dir(Vector3.RIGHT)
		
#		print(i)


func _physics_process(_delta):
	dir = Vector3.ZERO
	if Input.is_action_just_pressed("ui_up"): dir = Vector3.BACK
	if Input.is_action_just_pressed("ui_down"): dir = Vector3.FORWARD
	if Input.is_action_just_pressed("ui_left"): dir = Vector3.RIGHT
	if Input.is_action_just_pressed("ui_right"): dir = Vector3.LEFT
	
	if ext_dir != Vector3.ZERO:
		dir = ext_dir
		ext_dir = Vector3.ZERO
	
#	if dir != Vector3.ZERO:
#		print("Vector3" + str(dir) + ",")
	
	match dir:
		Vector3.BACK: rot_y = 0
		Vector3.FORWARD: rot_y = 180
		Vector3.RIGHT: rot_y = 90
		Vector3.LEFT: rot_y = -90
		
	
	if dir != Vector3.ZERO and dir != old_dir:
		old_dir = dir
		$ray1.translation = old_dir * 2 + Vector3.UP * 2.5
		$ray2.translation = old_dir * 4 + Vector3.UP * 2.5
		$ray3.translation = old_dir * 6 + Vector3.UP * 2.5
		$ray1.force_raycast_update()
		$ray2.force_raycast_update()
		$ray3.force_raycast_update()
	
	if dir != Vector3.ZERO:
		if $ray1.is_colliding():
			is_wall1 = $ray1.get_collider().is_in_group("wall")
			is_push1 = $ray1.get_collider().is_in_group("block")
		else:
			is_wall1 = false
			is_push1 = false
			
		if $ray2.is_colliding():
			is_wall2 = $ray2.get_collider().is_in_group("wall")
			is_push2 = $ray2.get_collider().is_in_group("block")
		else:
			is_wall2 = false
			is_push2 = false
			
		if $ray3.is_colliding():
			is_wall3 = true
		else:
			is_wall3 = false
		
		# block
		if is_wall1: 
			get_parent().shake()
			MusicController.play_suara_langkah()
			$AnimationTree.set("parameters/luka/active", true)
			print("Nabrak")
			
			health -= 15 
			get_parent().emit_signal("player_health", (float(health) / float(health_maks)) * 100)

			if health <= 0:
				mati()
		elif is_push1 and is_wall2:
			get_parent().shake()
			MusicController.play_suara_langkah()
			$AnimationTree.set("parameters/luka/active", true)
			print("Nabrak")
			
			health -= 15 
			get_parent().emit_signal("player_health", (float(health) / float(health_maks)) * 100)
			
			if health <= 0:
				mati()
		elif is_push1 and is_push2 and is_wall3:
			get_parent().shake()
			MusicController.play_suara_langkah()
			$AnimationTree.set("parameters/luka/active", true)
			print("Nabrak")
			
			health -= 15 
			get_parent().emit_signal("player_health", (float(health) / float(health_maks)) * 100)
			
			if health <= 0:
				mati()
		
		# pergerakan
		elif not is_push1 and not is_wall1:
			movement(dir)
		elif is_push1 and not is_wall2 and not is_push2:
			$ray1.get_collider().set_dir(dir)
			movement(dir)
		elif is_push1 and is_push2 and not is_wall3:
			$ray1.get_collider().set_dir(dir)
			$ray2.get_collider().set_dir(dir)
			movement(dir)
		
	if rot_y != old_rot_y and not is_rotating:
		is_rotating = true
		$AnimationTree.set("parameters/jalan/active", true)
		$tw_r.interpolate_property($pivot, "rotation_degrees:y", old_rot_y, rot_y, 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$tw_r.start()
		
		yield($tw_r, "tween_all_completed")
		old_rot_y = rot_y
		is_rotating = false
		

func _on_TimerHealth_timeout():
	health -= 10
	get_parent().emit_signal("player_health", (float(health) / float(health_maks)) * 100)
	
	if health <= 0:
		mati()


func movement(vec:Vector3):
	if is_moving == false && not sudah_mati:
		is_moving = true
		$AnimationTree.set("parameters/jalan/active", true)
		var a = translation
		var b = a + vec * 2
	
		MusicController.play_suara_langkah_alt()	
		$tw_m.interpolate_property(self, "translation", a, b, 0.15, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$tw_m.start()
		
		yield($tw_m, "tween_all_completed")
		
		if $ray_down.is_colliding() == false:
			if not sudah_mati:
				sudah_mati = true
				
				var c = b + Vector3.DOWN * 2
				$AnimationTree.set("parameters/transisi/current", 1)
				$tw_m.interpolate_property(self, "translation", b, c, 0.15, Tween.TRANS_EXPO, Tween.EASE_OUT)
				$tw_m.start()
				
				MusicController.play_suara_jatuh_air()
				health = 0 
				get_parent().emit_signal("player_health", (float(health) / float(health_maks)) * 100)
				yield(get_tree().create_timer(1.5), "timeout")
				
				MusicController.play_suara_game_over()
				print("Game Over")
				
				get_parent().emit_signal("player_mati")
				
	#			$fade/anim.play("to_black")
	#			yield($fade/anim, "animation_finished")
	#			var _err = get_tree().reload_current_scene()
		
		is_moving = false


#func add_health():
#	if get_parent().add_buah() == true:
#		health += 15
#		emit_signal("player_health", (float(health) / float(health_maks)) * 100)


func mati():
	if not sudah_mati:
		sudah_mati = true
		var a = translation
		
		$AnimationTree.set("parameters/transisi/current", 2)
		$tw_m.interpolate_property(self, "translation", a, a, 0.15, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$tw_m.start()
		
		yield($tw_m, "tween_all_completed")
		
		MusicController.play_suara_game_over()
		print("Game Over")
		
		get_parent().emit_signal("player_mati")
	
#	$fade/anim.play("to_black")
#	yield($fade/anim, "animation_finished")
#	var _err = get_tree().reload_current_scene()


func external_dir(vec:Vector3):
	ext_dir = vec


func _on_level_player_level_tbc():
	get_parent().get_node("UI/HealthBar/TimerHealth").stop()


func _on_level_player_menang():
	get_parent().get_node("UI/HealthBar/TimerHealth").stop()
