extends Position2D
class_name Dropzone

var filled = false

func _draw():
	var rect = Rect2(Vector2(-40, -40), Vector2(80, 80))
	draw_rect(rect, Color.blanchedalmond)

func select():
	modulate = Color.webmaroon
	filled = true

func deselect():
	modulate = Color.white
	filled = false
