extends Control

var draggable_img_scene: PackedScene = preload("res://gameplay/components/Draggable/DraggableImage.tscn")
var draggable_label_scene: PackedScene = preload("res://gameplay/components/Draggable/DraggableLabel.tscn")

func _ready():
	var draggables = get_tree().get_nodes_in_group("draggable")
	for drag in draggables:
		drag.connect("draggable_dropped", self, "_on_draggable_dropped")

func _on_draggable_dropped(draggable: Draggable):
	var spawn_point = draggable.spawn_point
	var index = draggable.index
	
	if draggable.is_in_group("draggable_image"):
		_spawn_new_draggable_img(draggable.sprite_path, spawn_point, index)
	else:
		_spawn_new_draggable_label(draggable.label_text, spawn_point, index)

func _spawn_new_draggable_img(sprite_path: String, spawn_point: Vector2, index: int) -> void:
	var draggable: Draggable = draggable_img_scene.instance()
	draggable.connect("draggable_dropped", self, "_on_draggable_dropped")
	draggable.sprite_path = sprite_path
	draggable.position = spawn_point
	draggable.index = index
	add_child(draggable)
	#print(get_tree().get_nodes_in_group("draggable"))

func _spawn_new_draggable_label(label_text: String, spawn_point: Vector2, index:int) -> void:
	var draggable: Draggable = draggable_label_scene.instance()
	draggable.connect("draggable_dropped", self, "_on_draggable_dropped")
	draggable.label_text = label_text
	draggable.position = spawn_point
	draggable.index = index
	add_child(draggable)
	#print(get_tree().get_nodes_in_group("draggable"))
