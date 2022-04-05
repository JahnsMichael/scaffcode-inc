extends "res://_dev/primo/Scripts/level/Draggable.gd"


export var label_text: String


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label_text
	$Label.rect_size = 2 * $CollisionShape2D.shape.extents
	$Label.rect_position = -0.5 * $Label.rect_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
