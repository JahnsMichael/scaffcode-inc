extends Label

export var label_text: String
var type: String setget set_type


func _ready() -> void:
	add_to_group("DRAGGABLE")
	add_to_group("LABEL")
	text = label_text


func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	return self


func _get_preview_control() -> Control:
	var drag_preview = Label.new()
	drag_preview.rect_size = rect_size
	drag_preview.text = text

	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control


func set_type(x_or_o: String):
	type = x_or_o
	text = "Hello"
