extends Node


signal addpoint(num: int)
var points: int = 0
var savepath = "user://points.sdb"

var annoyingevents = true
var madness = false


func savepoints():
	var file = FileAccess.open(savepath, FileAccess.WRITE)
	file.store_var(points)

func loadpoints():
	var file = FileAccess.open(savepath, FileAccess.READ)
	if file == null:
		savepoints()
		return
	points = file.get_var(points)

func _ready() -> void:
	loadpoints()
