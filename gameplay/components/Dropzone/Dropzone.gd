extends MarginContainer

export(int) var tile_size = 100

onready var _icon = $VBoxContainer/Icon
var row_index
var column_index


func _ready() -> void:
	rect_min_size = Vector2(tile_size, tile_size)

func can_drop_data(_position: Vector2, draggable) -> bool:
	var can_drop: bool = draggable is Node and draggable.is_in_group("DRAGGABLE")
	return can_drop

func drop_data(_position: Vector2, draggable: MarginContainer) -> void:
	_icon.texture = draggable.texture
	_icon.expand = true

func _on_ClearButton_pressed():
	clear()
	
func clear():
	_icon.texture = null
