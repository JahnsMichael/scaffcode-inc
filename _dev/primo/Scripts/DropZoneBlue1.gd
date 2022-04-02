extends Position2D

var filled = false

func _draw():
	var rect = Rect2(Vector2(-40, -40), Vector2(80, 80))
	draw_rect(rect, Color.aliceblue)

func select():
	modulate = Color.blueviolet
	filled = true

func deselect():
	modulate = Color.white
	filled = false
