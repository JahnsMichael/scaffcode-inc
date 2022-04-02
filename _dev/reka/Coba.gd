extends Node2D

func _ready():
	var dialog = Dialogic.start('cobaTimeline')
	add_child(dialog)

