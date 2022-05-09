extends MarginContainer
class_name ExDropzone

export(Array, Texture) var input_textures
export(Array, Texture) var state_textures
export(int) var tile_size = 100

var texture: Texture

func _ready() -> void:
	add_to_group("DRAGGABLE")
	$Icon.texture = state_textures[0]
	texture = $Icon.texture

func get_drag_data(_position: Vector2):
	var preview_control = Control.new()
	var preview_texture_rect = $Icon.duplicate()
	preview_texture_rect.rect_position = -0.5 * preview_texture_rect.rect_size
	preview_control.add_child(preview_texture_rect)
	set_drag_preview(preview_control)
	return self

func can_drop_data(_position: Vector2, draggable: ExDropzone) -> bool:
	return input_textures.has(draggable.texture)

func drop_data(_position: Vector2, draggable: ExDropzone) -> void:	
	$Icon.texture = state_textures[input_textures.find(draggable.texture)]
	$Icon.expand = true
	texture = $Icon.texture
	draggable.clear()

func clear():
	$Icon.texture = state_textures[0]
