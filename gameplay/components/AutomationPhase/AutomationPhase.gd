extends Control

var dropzones

func _ready():
	dropzones = get_tree().get_nodes_in_group("dropzone")
		
func _on_Reset_pressed():
	for dropzone in dropzones:
		dropzone.clear()

func _on_Run_pressed():
	for dropzone in dropzones:
		dropzone.validate()
