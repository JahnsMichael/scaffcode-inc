extends "res://_dev/jahns/Scripts/ClickableObject.gd"

export(String, FILE, "*.tscn") var target_scene_path

func on_click():
	print("Change scene")
	if ResourceLoader.exists(target_scene_path):
		var _error = get_tree().change_scene(target_scene_path)
		if _error:
			print(_error)
