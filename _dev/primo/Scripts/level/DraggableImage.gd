extends "res://_dev/primo/Scripts/level/Draggable.gd"

export(String, FILE, "*.png") var sprite_path

func _ready():
	$Sprite.texture = load(sprite_path)
