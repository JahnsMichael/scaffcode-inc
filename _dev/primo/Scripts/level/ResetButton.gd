extends LinkButton

func _on_ResetButton_pressed():
	var draggables = get_tree().get_nodes_in_group("draggable")
	for draggable in draggables:
		if draggable.rest_point != draggable.spawn_point:
			draggable._delete_node()
