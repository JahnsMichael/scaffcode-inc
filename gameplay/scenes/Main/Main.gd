extends Control

export(PackedScene) var play_scene
export(PackedScene) var credit_scene

func _on_PlayButton_pressed():
	var error = get_tree().change_scene_to(play_scene)
	if error:
		print(error)
