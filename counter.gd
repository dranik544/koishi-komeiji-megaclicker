extends Label


func _ready() -> void:
	Global.addpoint.connect(addpoint)

func _process(delta: float) -> void:
	#var windowsize = get_window().size
	#position.x = windowsize.x / 2
	#position.y = 0
	text = str(Global.points)

func addpoint(num: int = 1):
	Global.points += num
