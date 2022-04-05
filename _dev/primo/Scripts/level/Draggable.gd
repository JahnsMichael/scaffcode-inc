extends Area2D
class_name Draggable

var selected = false
var rest_point
var rest_node
var spawn_node
var drop_zones = []
var spawners = []

export var index = 0

signal draggable_dropped(draggable)

func _ready():
	spawners = get_tree().get_nodes_in_group("spawner")
	drop_zones = get_tree().get_nodes_in_group("zone")
	spawn_node = spawners[index]
	rest_node = spawners[index]
	rest_point = rest_node.global_position
	rest_node.select()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

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
			
			for child in drop_zones:
				var distance = global_position.distance_to(child.global_position)
				
				if distance < shortest_dist and child.filled == false:
					rest_node.deselect()
					spawn_node.deselect()
					rest_node = child
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
					
					emit_signal("draggable_dropped", self)
