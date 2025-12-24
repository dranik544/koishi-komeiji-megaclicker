extends Control

func _ready() -> void:
	get_window().transparent_bg = false
	get_window().transparent = false
	
	$vbox/annoyingevents.toggled.connect(_on_annoyingevents_toggled)
	$vbox/madness.toggled.connect(_on_madness_toggled)
	
	updateglobal()

func updateglobal():
	if Global:
		$vbox/annoyingevents.button_pressed = Global.annoyingevents
		$vbox/madness.button_pressed = Global.madness
		$vbox/annoyingevents.disabled = Global.madness

func _on_annoyingevents_toggled(toggled_on: bool) -> void:
	Global.annoyingevents = toggled_on

func _on_madness_toggled(toggled_on: bool) -> void:
	Global.madness = toggled_on
	$vbox/annoyingevents.disabled = toggled_on
	
	if toggled_on:
		Global.annoyingevents = true
		$vbox/annoyingevents.button_pressed = true

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://core.tscn")
