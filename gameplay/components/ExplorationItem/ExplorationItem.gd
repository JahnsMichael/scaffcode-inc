extends MarginContainer
class_name ExplorationItem

export(Array, Texture) var input_textures
export(Array, Texture) var state_textures
export var texture_visible = true
export var start_state = 0
export var callback_state = 0
export var randomized_drag_preview = false

var texture: Texture

func _ready() -> void:
	$Icon.rect_min_size = $Icon.rect_min_size * (get_viewport_rect().size.x / 1024)
	$Icon.texture = state_textures[start_state]
	texture = $Icon.texture
	if !texture_visible:
		$Icon.visible = false

func get_drag_data(_position: Vector2):
	var preview_control = Control.new()
	var preview_texture_rect = $Icon.duplicate()
	if randomized_drag_preview:
		texture = state_textures[randi() % len(state_textures)]
		preview_texture_rect.texture = texture
	preview_texture_rect.visible = true
	preview_texture_rect.rect_size = preview_texture_rect.rect_size * (get_viewport_rect().size.x / 1024)
	preview_texture_rect.rect_position = -0.5 * preview_texture_rect.rect_size
	preview_control.add_child(preview_texture_rect)
	set_drag_preview(preview_control)
	$DragAudioStreamPlayer.play()
	return self

func can_drop_data(_position: Vector2, draggable: ExplorationItem) -> bool:
	return input_textures.has(draggable.texture)

func drop_data(_position: Vector2, draggable: ExplorationItem) -> void:	
	$Icon.texture = state_textures[input_textures.find(draggable.texture)]
	$Icon.expand = true
	texture = $Icon.texture
	draggable.clear()
	$DropAudioStreamPlayer.play()

func clear():
	$Icon.texture = state_textures[callback_state]

