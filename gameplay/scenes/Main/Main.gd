extends Control

export(PackedScene) var play_scene
export(PackedScene) var credit_scene

func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_PlayButton_pressed():
	SceneChanger.change_scene_to(play_scene)
