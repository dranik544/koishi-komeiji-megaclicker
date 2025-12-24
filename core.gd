extends Node2D


func _ready() -> void:
	get_window().mouse_passthrough = false
	get_window().title = "Koishi"
	get_window().transparent_bg = true
	get_window().transparent = true
	#get_tree().get_root().transparent_bg = true

#func _process(delta: float) -> void:
	#var ws = get_window().size
	#if Input.is_action_pressed("A"): ws.x -= 2
	#if Input.is_action_pressed("D"): ws.x += 2
	#if Input.is_action_pressed("W"): ws.y -= 2
	#if Input.is_action_pressed("S"): ws.y += 2
	#
	#get_window().size = ws
