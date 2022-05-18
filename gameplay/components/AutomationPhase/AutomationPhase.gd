extends Control

# Attributes
export(Array, Texture) var spawners_texture
export(Array, Texture) var answers_texture
export(Array, String) var hint_dialog_names
export(String, MULTILINE) var bbcode_code_snippet
export(PackedScene) var exploration_preview_scene
export(PackedScene) var next_scene
export(String) var start_dialog_name
export(String) var help_dialog_name
export(String) var end_dialog_name

# References
onready var spawner_container: GridContainer = $Margin/HBoxContainer/ChoicesContainer/Body/ScrollContainer/MarginContainer/GridContainer
onready var dropzone_container: GridContainer = $Margin/HBoxContainer/AnswerContainer/Body/ScrollContainer/MarginContainer/GridContainer
onready var code_textbox: RichTextLabel = $Margin/HBoxContainer/VBoxContainer/ProgramContainer/Body/ScrollContainer/MarginContainer/Code
onready var video_container: VBoxContainer = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer
onready var exploration_viewport: Viewport = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer/Body/ViewportContainer/Viewport
onready var exploration_viewport_popup: Viewport = $Popup/ObjectiveVideoContainer2/Body/ViewportContainer/Viewport
onready var expand_video_button: Button = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer/Header/HBoxContainer/ExpandVideoButton
onready var third_column: VBoxContainer = $Margin/HBoxContainer/VBoxContainer
onready var popup: Popup = $Popup
onready var next_button: Button = $Margin/HBoxContainer/VBoxContainer/ProgramContainer/Header/HBoxContainer/Next

# Preloads
var dropzone_scene = preload("res://gameplay/components/Dropzone/Dropzone.tscn")
var spawner_scene = preload("res://gameplay/components/Spawner/Spawner.tscn")

# Constants
const empty_answer_bbcode_template = "[color=grey][wave amp=50 freq=2]..%s..[/wave][/color]"
const filled_answer_bbcode_template = "[img=%s]%s[/img]"

# States
var video_expanded = false

# Methods

func _ready():
	get_tree().paused = false
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	generate_spawners()
	generate_dropzones()
	generate_code_snippet()
	generate_viewports()
	
	yield(SceneChanger, "scene_changed")
	dialog(start_dialog_name)

func generate_spawners():
	for placeholder_spawner in spawner_container.get_children():
		placeholder_spawner.queue_free()
	for texture in spawners_texture:
		var spawner = spawner_scene.instance()
		spawner.texture = texture
		spawner_container.add_child(spawner)

func generate_dropzones():
	for placeholder_dropzone in dropzone_container.get_children():
		placeholder_dropzone.queue_free()
	for i in len(answers_texture):
		var dropzone = dropzone_scene.instance()
		dropzone.label_num = i + 1
		dropzone.answer_texture = answers_texture[i]
		dropzone.connect("data_changed", self,"_on_data_changed")
		dropzone.connect("hint_pressed", self,"_on_hint_pressed")
		dropzone_container.add_child(dropzone)

func generate_code_snippet():
	code_textbox.bbcode_text = bbcode_code_snippet
	for i in len(answers_texture):
		code_textbox.bbcode_text = replace_empty(code_textbox.bbcode_text, i+1)

func generate_viewports():
	exploration_viewport.get_child(0).queue_free()
	exploration_viewport_popup.get_child(0).queue_free()
	var exploration_viewport_popup_child = exploration_preview_scene.instance()
	var exploration_viewport_child = exploration_viewport_popup_child.duplicate()
	exploration_viewport_child.scale = Vector2(0.4, 0.4)
	exploration_viewport.add_child(exploration_viewport_child)
	exploration_viewport_popup.add_child(exploration_viewport_popup_child)
	exploration_viewport_popup.gui_disable_input = true

func replace_empty(text: String, index: int):
	var regex = RegEx.new()
	regex.compile("@%s" % index)
	return regex.sub(text, empty_answer_bbcode_template % index)

func replace_filled(text: String, index: int, texture: Texture):
	var regex = RegEx.new()
	regex.compile("@%s" % index)
	var width = float(15*texture.get_width()) / texture.get_height()
	return regex.sub(text, filled_answer_bbcode_template % [width ,texture.resource_path])

func _on_data_changed(_dropzone: Dropzone):
	var new_bbcode_text = bbcode_code_snippet
	for dropzone in dropzone_container.get_children():
		if dropzone._icon.texture == null:
			new_bbcode_text = replace_empty(
				new_bbcode_text,
				dropzone.label_num
			)
		else:
			new_bbcode_text = replace_filled(
				new_bbcode_text,
				dropzone.label_num,
				dropzone._icon.texture
			)
	code_textbox.bbcode_text = new_bbcode_text
	
func _on_hint_pressed(dropzone: Dropzone):
	dialog(hint_dialog_names[dropzone.label_num - 1])

func dialog(dialog_name):
	if !dialog_name:
		return

	var dialog = Dialogic.start(dialog_name)
	dialog.pause_mode = PAUSE_MODE_PROCESS
	get_parent().add_child(dialog)
	dialog.connect("timeline_end", self, "end_dialog")
	get_tree().paused = true

func end_dialog(_data):
	get_tree().paused = false

# Signals

func _on_Reset_pressed():
	for dropzone in dropzone_container.get_children():
		dropzone.clear()

func _on_Run_pressed():
	var all_true = true
	for dropzone in dropzone_container.get_children():
		all_true = dropzone.validate() && all_true
	if all_true:
		dialog(end_dialog_name)
		next_button.visible = true
	else:
		next_button.visible = false

func _on_ExpandVideoButton_pressed():
	if !video_expanded:
		popup.popup()
		exploration_viewport_popup.gui_disable_input = false
	else:
		popup.hide()
		exploration_viewport_popup.gui_disable_input = true
	video_expanded = !video_expanded

func _on_Next_pressed():
	SceneChanger.change_scene_to(next_scene)

func _on_HelpButton_pressed():
	dialog(help_dialog_name)
