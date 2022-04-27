extends MarginContainer

export(String, FILE, "*.png") var texture_path_1
export(String, FILE, "*.png") var texture_path_2
export(int) var tile_size = 100

var def_texture
var next_texture
var texture


func _ready() -> void:
	add_to_group("DRAGGABLE")
	$Background.color = Color.gray
	rect_min_size = Vector2(tile_size, tile_size)
	
	if texture_path_1 == null:
		return
	
	def_texture = load(texture_path_1)
	next_texture = load(texture_path_2)
	$Icon.texture = def_texture
	$Icon.expand = true
	texture = $Icon.texture


func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	return self


func _get_preview_control() -> Control:
	var drag_preview = TextureRect.new()
	drag_preview.rect_size = Vector2($Icon.texture.get_width(), $Icon.texture.get_height())
	drag_preview.texture = $Icon.texture

	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control


func can_drop_data(_position: Vector2, draggable) -> bool:
	var can_drop: bool = draggable is Node and draggable.is_in_group("DRAGGABLE")
	return can_drop


func drop_data(_position: Vector2, draggable: MarginContainer) -> void:	
	$Icon.texture = next_texture
	$Icon.expand = true
	texture = $Icon.texture
	
	if draggable.is_in_group("dropzone"):
		draggable.clear()


func clear():
	$Icon.texture = def_texture
