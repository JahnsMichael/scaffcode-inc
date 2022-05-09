extends MarginContainer
class_name Dropzone

export(int) var tile_size = 100
export(Texture) var answer_texture
export(StyleBoxFlat) var default_stylebox
export(StyleBoxFlat) var true_stylebox
export(StyleBoxFlat) var false_stylebox
export var label_num = 1

onready var _icon = $Icon
var bbcode_template = "[center][color=grey][wave amp=50 freq=2]..%s..[/wave][/color][/center]"
signal data_changed

func _ready() -> void:
	rect_min_size = Vector2(tile_size, tile_size)
	$Panel.add_stylebox_override("panel", default_stylebox)
	$Label.bbcode_text = bbcode_template % str(label_num)

func can_drop_data(_position: Vector2, draggable) -> bool:
	var can_drop: bool = draggable is Node and draggable.is_in_group("DRAGGABLE")
	return can_drop

func drop_data(_position: Vector2, draggable: MarginContainer) -> void:
	_icon.texture = draggable.texture
	_icon.expand = true
	$ClearButton.visible = true
	emit_signal("data_changed", self)

func _on_ClearButton_pressed():
	clear()
	
func clear():
	_icon.texture = null
	$Panel.add_stylebox_override("panel", default_stylebox)
	$ClearButton.visible = false
	emit_signal("data_changed", self)

func validate():
	if _icon.texture == null:
		return
		
	if _icon.texture != answer_texture :
		$Panel.add_stylebox_override("panel", false_stylebox)
	else:
		$Panel.add_stylebox_override("panel", true_stylebox)
