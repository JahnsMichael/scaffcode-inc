extends MarginContainer
class_name Spawner

var texture
onready var texture_rect = $TextureRect

func _ready() -> void:
	add_to_group("DRAGGABLE")
	add_to_group("IMAGE")
	texture_rect.texture = self.texture

func get_drag_data(_position: Vector2):
	var preview_control = Control.new()
	var preview_texture_rect = texture_rect.duplicate()
	preview_texture_rect.rect_position = -0.5 * preview_texture_rect.rect_size
	preview_control.add_child(preview_texture_rect)
	set_drag_preview(preview_control)
	return self
