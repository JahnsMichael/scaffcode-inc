extends MarginContainer
class_name Spawner

var texture: Texture
onready var texture_rect = $MarginContainer/TextureRect
onready var margin = $MarginContainer

func _ready() -> void:
	add_to_group("DRAGGABLE")
	add_to_group("IMAGE")
	texture_rect.texture = self.texture
	
func adjust_texture_margin():
	print(texture_rect.texture)
	if texture_rect.texture.width < 100:
		var margin_value = 20
		margin.add_constant_override("margin_top", margin_value)
		margin.add_constant_override("margin_left", margin_value)
		margin.add_constant_override("margin_bottom", margin_value)
		margin.add_constant_override("margin_right", margin_value)

func get_drag_data(_position: Vector2):
	var preview_control = Control.new()
	var preview_texture_rect = texture_rect.duplicate()
	preview_texture_rect.rect_position = -0.5 * preview_texture_rect.rect_size
	preview_control.add_child(preview_texture_rect)
	set_drag_preview(preview_control)
	$AudioStreamPlayer.play()
	return self
