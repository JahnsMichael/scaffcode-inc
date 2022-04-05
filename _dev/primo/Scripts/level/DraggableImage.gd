extends "res://_dev/primo/Scripts/level/Draggable.gd"


export(String, FILE, "*.png") var sprite_path


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load(sprite_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
