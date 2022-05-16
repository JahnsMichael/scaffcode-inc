extends ClickableObject
class_name DialogButton

export(String) var dialog_name
export(Texture) var texture

func _ready():
	if texture:
		$Sprite.texture = texture

func on_click():
	var dialog = Dialogic.start(dialog_name)
	dialog.pause_mode = PAUSE_MODE_PROCESS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_parent().add_child(dialog)
	dialog.connect("timeline_end", self, "end_dialog")
	dialog.connect("dialogic_signal", self, "dialog_listener")
	get_tree().paused = true

func dialog_listener(string):
	match string:
		"1":
			SceneChanger.change_scene("res://gameplay/scenes/ExplorationPhase/1_VariableDataType.tscn")
		"2":
			SceneChanger.change_scene("res://gameplay/scenes/ExplorationPhase/2_Collection.tscn")
		"3":
			SceneChanger.change_scene("res://gameplay/scenes/ExplorationPhase/3_Branching.tscn")
		"4":
			SceneChanger.change_scene("res://gameplay/scenes/ExplorationPhase/4_Loop.tscn")
			
func end_dialog(data):
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
