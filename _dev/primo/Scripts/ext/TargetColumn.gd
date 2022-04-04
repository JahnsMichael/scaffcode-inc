extends Panel

var draggable: PackedScene = preload("res://_dev/primo/Scenes/ext/draggable.tscn")
signal item_dropped_on_target(draggable)

func can_drop_data(position: Vector2, data) -> bool:
	#var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE")
	var can_drop = true
	print("[TargetColumn] can_drop_data has run, returning %s" % can_drop)
	return can_drop

func drop_data(position: Vector2, data) -> void:
	print("[TargetColumn] drop_data has run")
	print("[TargetColumn] Emiting signal: item_dropped_on_target")

	var draggable_copy: ColorRect = draggable.instance()
	draggable_copy.id = data.id
	draggable_copy.label = data.label
	draggable_copy.dropped_on_target = true # disable further dragging
	$TargetPadding/TargetRows.add_child(draggable_copy)

	emit_signal("item_dropped_on_target", data)

