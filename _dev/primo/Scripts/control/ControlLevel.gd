extends PanelContainer

export(int) var board_size: int = 3

var drop_zone_scene: PackedScene = preload("res://_dev/primo/Scenes/control/DropZone.tscn")
var drag_img_scene: PackedScene = preload("res://_dev/primo/Scenes/control/DragImage.tscn")
var drag_label_scene: PackedScene = preload("res://_dev/primo/Scenes/control/DragLabel.tscn")

onready var _grid: GridContainer = $VLayout/HLayout/GridContainer
onready var _draggable_container = $VLayout/HLayout/PanelContainer/DraggableContainer


func _ready() -> void:
	_setup_level()
	
	var reset_btn = $VLayout/ButtonContainer/Reset
	reset_btn.connect("reset_button_pressed", self, "_reset_level")


func _setup_level() -> void:
	#_spawn_new_draggable_image("X")
	#_spawn_new_draggable_label("O")
	_build_game_board()


func _reset_level():
	for i in _grid.get_children():
		_grid.remove_child(i)
		i.queue_free()
	
	#for j in _draggable_container.get_children():
	#	_draggable_container.remove_child(j)
	#	j.queue_free()
	
	_setup_level()


func _build_game_board() -> void:
	_grid.columns = board_size
	for row_index in board_size:
		for col_index in board_size:
			_grid.add_child(_spawn_new_drop_zone(col_index, row_index))


func _spawn_new_drop_zone(column_number: int, row_number: int) -> Node:
	var drop_zone = drop_zone_scene.instance()
	drop_zone.column_index = column_number
	drop_zone.row_index = row_number
	return drop_zone


func _spawn_new_draggable_image(x_or_o: String) -> void:
	var draggable = drag_img_scene.instance()
	draggable.type = x_or_o
	_draggable_container.add_child(draggable)


func _spawn_new_draggable_label(x_or_o: String) -> void:
	var draggable = drag_label_scene.instance()
	draggable.type = x_or_o
	_draggable_container.add_child(draggable)
