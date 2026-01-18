extends Control

func _ready() -> void:
	get_window().size = Vector2i(300, 375)
	get_window().position = Vector2i(
		DisplayServer.screen_get_size().x / 2 - get_window().size.x / 2,
		DisplayServer.screen_get_size().y / 2 - get_window().size.y / 2
	)
	
	get_window().transparent_bg = true
	get_window().transparent = true
	get_window().unfocusable = false
	get_window().always_on_top = false
	get_tree().get_root().set_transparent_background(true)
	
	$particles.position = get_tree().root.size / 2
	$particles.process_material.emission_box_extents.x = get_tree().root.size.x
	$particles.process_material.emission_box_extents.y = get_tree().root.size.y
	$particles.amount = (get_tree().root.size.x + get_tree().root.size.y) / 10
	$particles.emitting = true
	
	$scroll/vbox/annoyingevents.toggled.connect(_on_annoyingevents_toggled)
	$scroll/vbox/madness.toggled.connect(_on_madness_toggled)
	$scroll/vbox/transparent.toggled.connect(_on_transparent_bg_toggled)
	$scroll/vbox/customfumo.toggled.connect(_on_custom_fumo_toggled)
	$scroll/vbox/opencustomfumodir.pressed.connect(_on_open_dir_pressed)
	$scroll/vbox/timebeforeevents.value_changed.connect(_on_timebeforeevents_value_changed)
	#$scroll/vbox/texturefilter.item_selected.connect(_on_filtertexture_item_selected)
	
	$scroll/vbox/fumopath.text = ""
	_on_timebeforeevents_value_changed($scroll/vbox/timebeforeevents.value)
	
	updateglobal()

func updateglobal():
	if Global:
		$scroll/vbox/annoyingevents.button_pressed = Global.annoyingevents
		$scroll/vbox/madness.button_pressed = Global.madness
		$scroll/vbox/annoyingevents.disabled = Global.madness
		$scroll/vbox/customfumo.button_pressed = Global.customfumo

func _on_annoyingevents_toggled(toggled_on: bool) -> void:
	Global.annoyingevents = toggled_on

func _on_madness_toggled(toggled_on: bool) -> void:
	Global.madness = toggled_on
	$scroll/vbox/annoyingevents.disabled = toggled_on
	$scroll/vbox/timebeforeevents.editable = not toggled_on
	
	if toggled_on:
		var muhahawindow = Window.new()
		
		muhahawindow.size = Vector2i(225, 225)
		muhahawindow.borderless = true
		muhahawindow.transparent_bg = true
		muhahawindow.always_on_top = true
		muhahawindow.unfocusable = true
		
		get_tree().root.add_child(muhahawindow)
		
		var muhaha = load("res://muhaah.tscn").instantiate()
		muhahawindow.position = Vector2i(
			randi_range(255, DisplayServer.screen_get_size().x - 255),
			randi_range(255, DisplayServer.screen_get_size().y - 255)
		)
		
		muhahawindow.add_child(muhaha)
		
		$MUHAHAHAHAH.play()
		Global.annoyingevents = true
		$scroll/vbox/annoyingevents.button_pressed = true

func _on_transparent_bg_toggled(toggled_on: bool):
	Global.transparentbg = toggled_on

func _on_custom_fumo_toggled(toggled_on: bool):
	if toggled_on:
		if Global.loadcustomfumo() != null:
			Global.customfumo = true
			$"scroll/vbox/koishi lol".texture = Global.loadcustomfumo()
			$"scroll/vbox/koishi lol".size = Vector2(220, 220)
			$scroll/vbox/fumopath.text = "[wave]custom fumo found![/wave]"
		else:
			Global.customfumo = false
			$scroll/vbox/customfumo.button_pressed = false
			$scroll/vbox/fumopath.text = "[shake]custom fumo not found...[/shake]
			path to custom fumo windows:
			%APPDATA%/Godot/app_userdata/Koishi Komeiji MEGACLICKER/customfumo.png
			
			path to custom fumo linux:
			~/.local/share/godot/app_userdata/Koishi Komeiji MEGACLICKER/customfumo.png"
	else:
		Global.customfumo = false

func _on_timebeforeevents_value_changed(value: float):
	$scroll/vbox/timebeforeeventstext.text = "Time before events: ~" + str(value + (10 + 15 + value * 1.25) / 2) + "sec"
	Global.timebeforeevent = value

func _on_open_dir_pressed():
	OS.shell_open(OS.get_user_data_dir())

#func _on_filtertexture_item_selected(index: int):
	#ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", index)
	#ProjectSettings.save()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://core.tscn")
