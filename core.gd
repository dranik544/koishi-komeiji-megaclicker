extends Node2D


func _ready() -> void:
	get_window().mouse_passthrough = false
	get_window().title = "Koishi"
	get_window().unfocusable = true
	get_window().always_on_top = true
	get_window().size = Vector2i(225, 225)
	get_window().position = Vector2i(
		DisplayServer.screen_get_size().x / 2 - get_window().size.x / 2,
		DisplayServer.screen_get_size().y / 2 - get_window().size.y / 2
	)
	
	if Global.transparentbg:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.transparentbg:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)
	#get_tree().get_root().transparent_bg = true

#func _process(delta: float) -> void:
	#var ws = get_window().size
	#if Input.is_action_pressed("A"): ws.x -= 2
	#if Input.is_action_pressed("D"): ws.x += 2
	#if Input.is_action_pressed("W"): ws.y -= 2
	#if Input.is_action_pressed("S"): ws.y += 2
	#
	#get_window().size = ws
