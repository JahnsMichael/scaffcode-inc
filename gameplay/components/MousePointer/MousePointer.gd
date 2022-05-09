extends Sprite

func _process(_delta):
	position = get_parent().get_local_mouse_position()
