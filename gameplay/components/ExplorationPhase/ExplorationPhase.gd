extends CanvasItem

export(String) var dialog_name

func _ready():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	yield(SceneChanger, "scene_changed")
	start_dialog()

func start_dialog():
	if dialog_name:
		var dialog = Dialogic.start(dialog_name)
		dialog.pause_mode = PAUSE_MODE_PROCESS
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		self.add_child(dialog)
		dialog.connect("timeline_end", self, "end_dialog")
		dialog.connect("dialogic_signal", self, "dialog_listener")
		get_tree().paused = true

func end_dialog(data):
	get_tree().paused = false
