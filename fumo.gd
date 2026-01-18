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
	if Global.hascustomfumo() != null and Global.customfumo:
		$fumospritebg.texture = Global.loadcustomfumo()
		$fumosprite.texture = Global.loadcustomfumo()
	
	if Global.madness:
		$Timer.wait_time = 3
	else:
		#$Timer.wait_time = 2
		$Timer.wait_time = randf_range(10.0 + Global.timebeforeevent, 15.0 + Global.timebeforeevent * 1.25)
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
	
	
	
	if Input.is_action_just_pressed("RCM"): Global.savepoints(); get_tree().quit()
	
	
	
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
		randomevent = randi_range(1, 11)
	else:
		if get_window().has_meta("copy") and get_window().get_meta("copy"):
			var events = [1, 3, 4, 6, 7, 9, 10]
			randomevent = events[randi() % events.size()]
		else:
			randomevent = randi_range(1, 11)
	
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
			
			await get_tree().create_timer(2.1).timeout
			get_window().position = Vector2i(-225, -225)
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
			
			if !Global.madness:
				await get_tree().create_timer(randf_range(5, 15)).timeout
				var targetjumppos = Vector2i(new_window.position.x, -225)
				create_tween().tween_property(new_window, "position", targetjumppos, 0.75)
				$AudioStreamPlayer4.play()
				
				await get_tree().create_timer(0.8).timeout
				new_window.queue_free()
		7:
			if Global.annoyingevents:
				var new_window = Window.new()
				new_window.size = Vector2i(225, 225)
				new_window.borderless = true
				new_window.transparent_bg = true
				new_window.always_on_top = true
				new_window.unfocusable = true
				
				var pos = get_window().position
				var screensize: Vector2i = DisplayServer.screen_get_size()
				var targetpos = Vector2i(
					randi_range(0, screensize.x - get_window().size.x),
					randi_range(0, screensize.y - get_window().size.y)
				)
				create_tween().tween_property(get_window(), "position", targetpos, 1.6)
				run = true
				$AudioStreamPlayer.play()
				await get_tree().create_timer(1.6).timeout
				run = false
				await get_tree().create_timer(1.3).timeout
				
				get_tree().root.add_child(new_window)
				var ops = load("res://lmao.tscn").instantiate()
				new_window.add_child(ops)
				new_window.position = get_window().position + Vector2i(randi_range(-50, 50), randi_range(-50, 50))
				new_window.show()
				
				await get_tree().create_timer(0.6).timeout
				create_tween().tween_property(get_window(), "position", pos, 0.25)
				$AudioStreamPlayer7.play()
				await get_tree().create_timer(0.25).timeout
				$fumosprite.scale = Vector2(1.0, 1.0)
				$fumospritebg.scale = $fumosprite.scale
		8:
			if Global.annoyingevents:
				var new_window = Window.new()
				new_window.size = Vector2i(DisplayServer.screen_get_size())
				new_window.borderless = false
				new_window.mode = Window.MODE_FULLSCREEN
				new_window.transparent_bg = true
				new_window.always_on_top = true
				new_window.unfocusable = true
				
				get_tree().root.add_child(new_window)
				var bugaga = load("res://fullscreen_screamer.tscn").instantiate()
				new_window.add_child(bugaga)
				
				new_window.show()
				
				await get_tree().create_timer(0.75).timeout
				create_tween().tween_property(new_window.get_node("fullscreen screamer").get_node("texture"), "modulate:a", 0.0, 0.2)
				await get_tree().create_timer(0.2).timeout
				new_window.queue_free()
		9:
			if Global.annoyingevents:
				var whaticangoogle = [
					"https://www.google.com/search?q=how+to+poop",
					"https://www.google.com/search?q=how+buy+original+fumo",
					"https://www.google.com/search?q=poops+lol+ahahahha",
					"https://www.google.com/search?q=KFC",
					"https://www.google.com/search?q=koishi+arts+UwU",
					"https://www.google.com/search?q=koocies",
					"https://www.google.com/search?q=free+manecravt+dowload+free+wizaut+virus",
					"https://www.google.com/search?q=COOL+FARTS+VIDEO",
					"https://www.google.com/search?q=Do+calories+burn+when+I+fart%3F",
					"https://www.google.com/search?q=Germany+is+in+what+country%3F",
					"https://www.google.com/search?q=Is+the+Tooth+Fairy+real%3F",
					"https://www.google.com/search?q=meow",
					"https://www.google.com/search?q=why+i+stupit+?!&!&&!&!!?!?!",
					"https://www.google.com/search?q=qwertyuiopasdfghjklzxcvbnm",
					"https://www.google.com/search?q=ran+yakumo+boobs",
					"https://rule34.xxx/",
					"https://www.google.com/search?q=2+plus+2+equals+what",
					"https://www.google.com/search?q=scary+gensokyo+stories"
				]
				
				OS.shell_open(whaticangoogle[randi() % whaticangoogle.size()])
		10:
			if Global.annoyingevents:
				$AudioStreamPlayer8.play()
				
				if Global.madness: updateeventtimer()
				
				for i in randi_range(8, 15):
					var new_window = Window.new()
					new_window.size = Vector2i(randi_range(100, 550) * 1.5, randi_range(100, 550))
					new_window.borderless = true
					new_window.transparent_bg = true
					new_window.always_on_top = true
					new_window.unfocusable = true
					
					get_tree().root.add_child(new_window)
					var ops = load("res://fart.tscn").instantiate()
					new_window.add_child(ops)
					new_window.show()
					
					await get_tree().create_timer(randf_range(1.0, 7.5)).timeout
		11:
			$AnimationPlayer.play("zametka")
			await $AnimationPlayer.animation_finished
			
			var new_window = Window.new()
			new_window.size = Vector2i(225, 225)
			new_window.borderless = true
			new_window.always_on_top = true
			new_window.unfocusable = true
			new_window.position = get_window().position
			
			get_tree().root.add_child(new_window)
			var question = load("res://zametka.tscn").instantiate()
			new_window.add_child(question)
			
			$AudioStreamPlayer9.play()
			
			new_window.show()
	
	updateeventtimer()

func updateeventtimer():
	if Global.madness: $Timer.wait_time = randf_range(0.5, 5)
	else: $Timer.wait_time = randf_range(10.0 + Global.timebeforeevent, 15.0 + Global.timebeforeevent * 1.25)
	$Timer.start()
	
	isevent = false
