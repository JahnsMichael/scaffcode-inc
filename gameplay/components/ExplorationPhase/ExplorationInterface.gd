extends MarginContainer

export(PackedScene) var next_scene

func _on_Button_pressed():
	SceneChanger.change_scene_to(next_scene)
