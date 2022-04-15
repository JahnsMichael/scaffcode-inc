extends "res://_dev/primo/Scripts/level/Draggable.gd"

export var label_text: String

func _ready():
	$Label.text = label_text
	$Label.rect_size = 2 * $CollisionShape2D.shape.extents
	$Label.rect_position = -0.5 * $Label.rect_size
