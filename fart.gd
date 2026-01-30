extends Control


func _ready() -> void:
	get_window().mouse_passthrough = true
	get_window().title = "govno"
	get_window().unfocusable = true
	get_window().always_on_top = true
	get_window().borderless = true
	
	if Global.settings["transparentbg"]:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.settings["transparentbg"]:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)
	
	var randomtime = randf_range(15.0, 40.0)
	
	$TextureRect.modulate.a = 0.0
	get_window().position.x = -randi_range(225, 1100) + get_window().size.x
	get_window().position.y = randi_range(25, DisplayServer.screen_get_size().y)
	create_tween().tween_property($TextureRect, "modulate:a", randf_range(0.2, 0.8), 1.0)
	create_tween().tween_property(get_window(), "position:x", DisplayServer.screen_get_size().x + size.x, randomtime)
	await get_tree().create_timer(randomtime + 0.5).timeout
	get_window().queue_free()
