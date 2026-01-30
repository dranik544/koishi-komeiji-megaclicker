extends Control

var images = [
	preload("res://screamer1.jpg"),
	preload("res://screamer2.jpg"),
	preload("res://screamer3.jpg"),
	preload("res://screamer4.jpg"),
	preload("res://screamer5.png"),
	preload("res://screamer6.png"),
	preload("res://screamer7.jpg"),
	preload("res://screamer8.jpg"),
	preload("res://screamer9.jpg"),
	preload("res://screamer10.jpg"),
	preload("res://screamer11.jpg"),
	preload("res://screamer12.jpg"),
	preload("res://screamer13.jpg"),
	preload("res://screamer14.jpg"),
	preload("res://screamer15.jpg"),
	preload("res://screamer16.jpg"),
	preload("res://screamer17.jpg"),
	preload("res://screamer18.jpg"),
	preload("res://screamer19.jpg"),
	preload("res://screamer20.jpg"),
	preload("res://screamer21.jpg"),
	preload("res://screamer22.jpg"),
	preload("res://screamer23.jpg"),
	preload("res://screamer24.jpg"),
	preload("res://screamer25.jpg"),
	preload("res://screamer26.jpg"),
	preload("res://screamer27.jpg"),
	preload("res://screamer28.jpg"),
]


func _ready() -> void:
	get_window().mouse_passthrough = true
	get_window().title = "BOOOOM!"
	get_window().unfocusable = true
	get_window().always_on_top = true
	
	if Global.settings["transparentbg"]:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.settings["transparentbg"]:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)
	
	$texture.texture = images[randi() % images.size()]
