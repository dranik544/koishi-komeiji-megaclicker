extends StaticBody2D

var drag: bool = false
var mousemotion: Vector2 = Vector2.ZERO
var dragoffset
var run: bool = false
var time: float = 0.0
var isevent: bool = false
var eventdrag: bool = false
var clicks: int = 0
var clicksreached: bool = false


func apply_settings():
	if Global.madness:
		$Timer.wait_time = 3
	else:
		$Timer.wait_time = randf_range(25, 240)
	$Timer.start()

func _ready():
	Global.addpoint.connect(addpoint)
	apply_settings()

func addpoint(_num: int):
	clicks += 1
	
	if eventdrag and clicks >= 10 and not clicksreached:
		clicksreached = true
		eventdrag = false
		drag = false
		$"../ineed10clicks".visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousemotion = event.relative

func _process(delta: float) -> void:
	time += delta
	
	var windowsize = get_window().size
	position = windowsize / 2
	
	if Input.is_action_just_pressed("LCM"):
		var mpos = DisplayServer.mouse_get_position()
		var wpos = get_window().position
		dragoffset = Vector2(mpos) - Vector2(wpos)
		Global.addpoint.emit(1)
	
	if Input.is_action_pressed("LCM"):
		drag = true
	else:
		if !eventdrag: drag = false
	
	if drag:
		var mpos = DisplayServer.mouse_get_position()
		if dragoffset: 
			get_window().position = Vector2i(Vector2(mpos) - dragoffset)
		else: 
			get_window().position = Vector2i(Vector2(mpos - windowsize / 2))
		rotation = lerp(rotation, mousemotion.x / 10, 5 * delta)
	
	rotation = lerp(rotation, 0.0, 10 * delta)
	
	if run:
		$fumosprite.scale = Vector2(1.0, 1.0) + Vector2(sin(time * 10) * 0.05, sin(time * 20) * 0.05)
		$fumospritebg.scale = $fumosprite.scale
	
	$"../ineed10clicks".visible = eventdrag and clicks < 10

func _on_timer_timeout() -> void:
	if isevent: 
		return
	
	isevent = true
	var randomevent
	if !Global.madness:
		randomevent = randi_range(1, 6)
	else:
		if get_window().has_meta("copy") and get_window().get_meta("copy"):
			var events = [1, 3, 4, 6]
			randomevent = events[randi() % events.size()]
		else:
			randomevent = randi_range(1, 6)
	
	match randomevent:
		1:
			var tween = create_tween()
			var screensize: Vector2i = DisplayServer.screen_get_size()
			var randomrunpos = Vector2i(
				randi_range(0, screensize.x - get_window().size.x),
				randi_range(0, screensize.y - get_window().size.y)
			)
			tween.tween_property(get_window(), "position", randomrunpos, randf_range(2,4))
			$AudioStreamPlayer.play()
			run = true
			
			await tween.finished
			run = false
			$fumosprite.scale = Vector2(1.0, 1.0)
			$fumospritebg.scale = $fumosprite.scale
			
		2:
			var randomart = randi_range(1, 10)
			$art.texture = load("res://koishiart" + str(randomart) + ".png")
			$AnimationPlayer.play("paint")
			await $AnimationPlayer.animation_finished
			
		3:
			create_tween().tween_property(self, "modulate:a", 0.0, 2)
			create_tween().tween_property($"../Label", "modulate:a", 0.0, 2)
			create_tween().tween_property($"../Button", "modulate:a", 0.0, 2)
			
			$AudioStreamPlayer3.pitch_scale = 1.0
			$AudioStreamPlayer3.play()
			
			await get_tree().create_timer(randf_range(10, 25)).timeout
			
			var screensize: Vector2i = DisplayServer.screen_get_size()
			get_window().position = Vector2i(
				randi_range(0, screensize.x - get_window().size.x),
				randi_range(0, screensize.y - get_window().size.y)
			)
			
			create_tween().tween_property(self, "modulate:a", 1.0, 2)
			create_tween().tween_property($"../Label", "modulate:a", 1.0, 2)
			create_tween().tween_property($"../Button", "modulate:a", 1.0, 2)
			$AudioStreamPlayer3.pitch_scale = 2.0
			$AudioStreamPlayer3.play()
			
		4:
			create_tween().tween_property(get_window(), "position:y", -225, 0.5)
			$AudioStreamPlayer4.play()
			
			await get_tree().create_timer(randf_range(3, 6)).timeout
			
			var screensize: Vector2i = DisplayServer.screen_get_size()
			var randx = randi_range(0, screensize.x - get_window().size.x)
			get_window().position = Vector2i(randx, -225)
			var targetpos = Vector2i(randx, randi_range(screensize.y / 2, screensize.y - get_window().size.y))
			create_tween().tween_property(get_window(), "position", targetpos, 4.5)
			$AudioStreamPlayer5.play()
			
		5:
			if Global.annoyingevents:
				clicks = 0
				clicksreached = false
				eventdrag = true
				drag = true
				$"../ineed10clicks".visible = true
				
				while not clicksreached:
					await get_tree().process_frame
		6:
			var new_window = Window.new()
			new_window.size = Vector2i(225, 225)
			new_window.borderless = true
			new_window.transparent_bg = true
			new_window.always_on_top = true
			new_window.unfocusable = true
			new_window.set_meta("copy", true)
			
			get_tree().root.add_child(new_window)
			var koishiii = load("res://core.tscn").instantiate()
			new_window.add_child(koishiii)
			$AudioStreamPlayer6.play()
			
			new_window.position = get_window().position + Vector2i(randi_range(-50, 50), randi_range(-50, 50))
			new_window.show()
			
			var targetpos = get_window().position + Vector2i(randi_range(-500, 500), randi_range(-500, 500))
			create_tween().tween_property(new_window, "position", targetpos, 0.2)
			
			await get_tree().create_timer(randf_range(5, 15)).timeout
			var targetjumppos = Vector2i(new_window.position.x, -225)
			create_tween().tween_property(new_window, "position", targetjumppos, 0.75)
			$AudioStreamPlayer4.play()
			
			if !Global.madness:
				await get_tree().create_timer(0.8).timeout
				new_window.queue_free()
	
	if Global.madness: $Timer.wait_time = randf_range(2, 5)
	else: $Timer.wait_time = randf_range(25, 240)
	$Timer.start()
	
	isevent = false
