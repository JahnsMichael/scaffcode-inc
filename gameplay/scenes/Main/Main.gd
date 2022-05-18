extends Control

export(PackedScene) var play_scene

onready var popup = $PopupPanel

func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_PlayButton_pressed():
	SceneChanger.change_scene_to(play_scene)


func _on_CreditButton_pressed():
	popup.popup()
