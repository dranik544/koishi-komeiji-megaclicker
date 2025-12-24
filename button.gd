extends Button

var max_distance = 50.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse = get_global_mouse_position()
		var buttoncenter = global_position + (size / 2)
		var distance = buttoncenter.distance_to(mouse)
		var alpha = clamp(1.0 - (distance / max_distance), 0.0, 1.0)
		modulate = Color(1.0, 1.0, 1.0, alpha)

func _on_pressed() -> void:
	Global.savepoints()
	get_tree().quit()
