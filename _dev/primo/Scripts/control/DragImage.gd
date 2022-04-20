extends TextureRect

export(String, FILE, "*.png") var texture_path
var type: String setget set_type


func _ready() -> void:
	add_to_group("DRAGGABLE")
	add_to_group("IMAGE")
	texture = load(texture_path)


func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	return self


func _get_preview_control() -> Control:
	var drag_preview = TextureRect.new()
	drag_preview.rect_size = Vector2(texture.get_width(),texture.get_height())
	drag_preview.texture = texture

	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control


func set_type(x_or_o: String):
	type = x_or_o
	texture = load("res://icon.png")
