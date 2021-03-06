extends MarginContainer
class_name Dropzone

export(int) var tile_size = 100
export(Texture) var answer_texture
export(StyleBoxFlat) var default_stylebox
export(StyleBoxFlat) var true_stylebox
export(StyleBoxFlat) var false_stylebox
export var label_num = 1

onready var _icon = $MarginContainer/Icon
onready var clear_button = $Panel/HBoxContainer/ClearButton
onready var hint_button = $Panel/HBoxContainer/HintButton
var bbcode_template = "[center][color=grey][wave amp=50 freq=2]..%s..[/wave][/color][/center]"

signal data_changed
signal hint_pressed

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
	clear_button.visible = true
	$AudioStreamPlayer.play()
	emit_signal("data_changed", self)

func _on_ClearButton_pressed():
	clear()
	
func clear():
	_icon.texture = null
	$Panel.add_stylebox_override("panel", default_stylebox)
	clear_button.visible = false
	hint_button.visible = false
	$AudioStreamPlayer.play()
	emit_signal("data_changed", self)

func validate() -> bool:
	if _icon.texture == null:
		return false
		
	hint_button.visible = false
		
	if _icon.texture != answer_texture :
		$Panel.add_stylebox_override("panel", false_stylebox)
		hint_button.visible = true
	else:
		$Panel.add_stylebox_override("panel", true_stylebox)

	return _icon.texture == answer_texture


func _on_HintButton_pressed():
	emit_signal("hint_pressed", self)
