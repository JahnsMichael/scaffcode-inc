extends TextureRect

export(int) var tile_size = 100

var holds_draggable: bool = false
#var row_index
#var column_index


func _ready() -> void:
	rect_min_size = Vector2(tile_size, tile_size)


func get_drag_data(_position: Vector2):
	if texture != null:
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


func can_drop_data(_position: Vector2, draggable) -> bool:
	if holds_draggable:
		return false
		
	var can_drop: bool = draggable is Node and draggable.is_in_group("DRAGGABLE")
	
	return can_drop


func drop_data(_position: Vector2, draggable: TextureRect) -> void:
	texture = draggable.texture
	add_to_group("DRAGGABLE")
	holds_draggable = true
	_center_piece()


func _center_piece() -> void:
	var padding = (tile_size - texture.get_width())/2
	margin_left = padding
	margin_top = padding
