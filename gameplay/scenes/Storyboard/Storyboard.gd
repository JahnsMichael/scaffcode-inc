extends Control

func _ready():
	yield(SceneChanger, "scene_changed")
	start_dialog()

func start_dialog():
	var dialog = Dialogic.start("Storyboard")
	dialog.pause_mode = PAUSE_MODE_PROCESS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.add_child(dialog)
	dialog.connect("timeline_end", self, "end_dialog")
	dialog.connect("dialogic_signal", self, "dialog_listener")
	get_tree().paused = true

func dialog_listener(_string):
	SceneChanger.change_scene("res://gameplay/scenes/Maps/JuiceBar.tscn")

func end_dialog(_data):
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
