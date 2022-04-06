extends Position2D
class_name Spawner

var filled = false

func _draw():
	var rect = Rect2(Vector2(-40, -40), Vector2(80, 80))
	draw_rect(rect, Color.lightblue)

func select():
	modulate = Color.midnightblue
	filled = true

func deselect():
	modulate = Color.white
	filled = false
