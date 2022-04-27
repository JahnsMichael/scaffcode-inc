extends MarginContainer
class_name Spawner

export(String, FILE, "*.png") var texture_path

var texture


func _ready() -> void:
	add_to_group("DRAGGABLE")
	add_to_group("IMAGE")
	if texture_path == null:
		return
	$TextureRect.texture = load(texture_path)
	texture = $TextureRect.texture

func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	return self

func _get_preview_control() -> Control:
	var drag_preview = TextureRect.new()
	drag_preview.rect_size = Vector2($TextureRect.texture.get_width(), $TextureRect.texture.get_height())
	drag_preview.texture = $TextureRect.texture

	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control
