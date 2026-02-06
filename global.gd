extends Node


signal addpoint(num: int)
var points: int = 0
var savepath = "user://points.sdb"
var customfumopath = "user://customfumo.png"

var settings = {
	"annoyingevents": true,
	"madness": false,
	"transparentbg": true,
	"customfumo": false,
	"timebeforeevent": 240.0,
	"disableevents": false,
}


func savepoints():
	var file = FileAccess.open(savepath, FileAccess.WRITE)
	file.store_var(points)

func loadpoints():
	var file = FileAccess.open(savepath, FileAccess.READ)
	if file == null:
		savepoints()
		return
	points = file.get_var(points)

func loadcustomfumo():
	var image = Image.new()
	
	if image.load(customfumopath) == OK:
		var texture = ImageTexture.create_from_image(image)
		return texture
	else:
		return null

func hascustomfumo():
	return FileAccess.file_exists(customfumopath)

func _ready() -> void:
	loadpoints()
