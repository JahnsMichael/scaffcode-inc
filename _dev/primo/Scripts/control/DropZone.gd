extends PanelContainer

export(int) var tile_size = 100

#onready var _icon = $Icon
#var draggable_scene: PackedScene = preload("res://_dev/primo/Scenes/control/DragImage.tscn")
#var holds_draggable: bool = false
var row_index
var column_index


func _ready() -> void:
	rect_min_size = Vector2(tile_size, tile_size)
#	pass


#func can_drop_data(_position: Vector2, draggable) -> bool:
#	if holds_draggable:
#		return false
	
#	var can_drop: bool = draggable is Node and draggable.is_in_group("DRAGGABLE")
#	if can_drop:
#		draggable
#	return can_drop


#func drop_data(_position: Vector2, draggable: TextureRect) -> void:
#	_icon.texture = draggable.texture
#	_icon.add_to_group("DRAGGABLE")
#	holds_draggable = true
	#_center_piece()


#func _center_piece() -> void:
#	var padding = (tile_size - _icon.texture.get_width())/2
#	icon.margin_left = padding
#	icon.margin_top = padding
