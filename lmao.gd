extends Node2D


func _ready() -> void:
	get_window().mouse_passthrough = false
	get_window().title = "hohoho lmao"
	get_window().unfocusable = true
	get_window().always_on_top = true
	
	if Global.transparentbg:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.transparentbg:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)

func _on_button_pressed() -> void:
	$Button.disabled = true
	$Button.focus_mode = false
	create_tween().tween_property($Button, "scale", Vector2(0, 0), 6.5)
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(6.5).timeout
	get_window().queue_free()
