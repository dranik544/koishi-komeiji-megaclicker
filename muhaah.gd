extends Node2D


func _ready() -> void:
	get_window().mouse_passthrough = true
	get_window().title = "muahhaha"
	get_window().unfocusable = true
	get_window().always_on_top = true
	get_window().borderless = true
	
	if Global.transparentbg:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.transparentbg:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)
	
	create_tween().tween_property($TextureRect, "modulate:a", 0.0, 3.0)
	await get_tree().create_timer(3.1).timeout
	get_window().queue_free()
