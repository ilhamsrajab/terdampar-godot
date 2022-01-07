extends Area

func _on_apel_body_entered(body):
	if body.is_in_group("player"):
		get_parent().add_buah()
		queue_free()
