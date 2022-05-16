extends Control

export(PackedScene) var play_scene
export(PackedScene) var credit_scene

func _on_PlayButton_pressed():
	SceneChanger.change_scene_to(play_scene)
