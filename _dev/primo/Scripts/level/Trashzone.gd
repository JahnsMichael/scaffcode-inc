extends Position2D
class_name Trashzone

func _draw():
	var rect = Rect2(Vector2(-40, -40), Vector2(80, 80))
	draw_rect(rect, Color.webmaroon)