extends Area2D
# class_name Draggable

var selected = false
var rest_point
var rest_node
var spawn_point
var spawn_node
var drop_zones = []
var spawners = []

export var index = 0

signal draggable_dropped(draggable)

func _ready():
	spawners = get_tree().get_nodes_in_group("spawner")
	drop_zones = get_tree().get_nodes_in_group("dropzone")
	spawn_node = spawners[index]
	rest_node = spawners[index]
	spawn_point = spawn_node.rect_global_position
	rest_point = rest_node.rect_global_position
	rest_node.select()

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 60
			
			for drop_zone in drop_zones:
				var distance = global_position.distance_to(drop_zone.rect_global_position)
				
				if distance < shortest_dist and drop_zone.filled == false:
					
					if rest_node == spawn_node:
						spawn_node.deselect()
						emit_signal("draggable_dropped", self)
					else:
						rest_node.deselect()
					
					rest_node = drop_zone
					drop_zone.select()
					rest_point = drop_zone.rect_global_position
					shortest_dist = distance
			
			_is_draggable_over_trash(shortest_dist)

func _is_draggable_over_trash(shortest_dist: int):
	var trash_can = get_tree().get_nodes_in_group("trash")
	if (len(trash_can) == 0):
		return 
		
	var distance = global_position.distance_to(trash_can[0].global_position)
	
	if distance < shortest_dist:
		if rest_node != spawn_node:
			_delete_node()
	return

func _delete_node():
	rest_node.deselect()
	self.queue_free()


func _on_Draggable_input_event(viewport, event, shape_idx):
	print("clicked")
	if Input.is_action_just_pressed("click"):
		selected = true