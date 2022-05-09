extends Control

# Attributes
export(Array, Texture) var spawners_texture
export(Array, Texture) var answers_texture
export(String, MULTILINE) var bbcode_code_snippet
export(VideoStreamWebm) var video_stream

# References
onready var spawner_container: GridContainer = $Margin/HBoxContainer/ChoicesContainer/Body/ScrollContainer/MarginContainer/GridContainer
onready var dropzone_container: GridContainer = $Margin/HBoxContainer/AnswerContainer/Body/ScrollContainer/MarginContainer/GridContainer
onready var code_textbox: RichTextLabel = $Margin/HBoxContainer/VBoxContainer/ProgramContainer/Body/MarginContainer/Code
onready var video_container: VBoxContainer = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer
onready var video_player: VideoPlayer = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer/Body/VideoPlayer
onready var play_video_button: Button = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer/Header/HBoxContainer/PlayVideoButton
onready var expand_video_button: Button = $Margin/HBoxContainer/VBoxContainer/ObjectiveVideoContainer/Header/HBoxContainer/ExpandVideoButton
onready var third_column: VBoxContainer = $Margin/HBoxContainer/VBoxContainer
onready var popup: Popup = $Popup

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
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	clean_up()
	generate_spawners()
	generate_dropzones()
	generate_code_snippet()
	
func clean_up():
	for placeholder_spawner in spawner_container.get_children():
		placeholder_spawner.queue_free()
	for placeholder_dropzone in dropzone_container.get_children():
		placeholder_dropzone.queue_free()	

func generate_spawners():
	for texture in spawners_texture:
		var spawner = spawner_scene.instance()
		spawner.texture = texture
		spawner_container.add_child(spawner)
		
func generate_dropzones():
	for i in len(answers_texture):
		var dropzone = dropzone_scene.instance()
		dropzone.label_num = i + 1
		dropzone.answer_texture = answers_texture[i]
		dropzone.connect("data_changed", self,"_on_data_changed")
		dropzone_container.add_child(dropzone)

func generate_code_snippet():
	code_textbox.bbcode_text = bbcode_code_snippet
	for i in len(answers_texture):
		code_textbox.bbcode_text = replace_empty(code_textbox.bbcode_text, i+1)
		
func generate_video():
	video_player.stream = video_stream
		
func replace_empty(text: String, index: int):
	var regex = RegEx.new()
	regex.compile("@%s" % index)
	return regex.sub(text, empty_answer_bbcode_template % index)
	
func replace_filled(text: String, index: int, texture: Texture):
	var regex = RegEx.new()
	regex.compile("@%s" % index)
	var width = float(40*texture.get_width()) / texture.get_height()
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

# Signals

func _on_Reset_pressed():
	for dropzone in dropzone_container.get_children():
		dropzone.clear()

func _on_Run_pressed():
	for dropzone in dropzone_container.get_children():
		dropzone.validate()

func _on_PlayVideoButton_pressed():
	if video_player.paused:
		play_video_button.text = "Pause"
		video_player.play()
	else:
		play_video_button.text = "Play"
	video_player.paused = !video_player.paused

func _on_ExpandVideoButton_pressed():
	if !video_expanded:
		third_column.remove_child(video_container)
		popup.get_child(0).add_child(video_container)
		popup.popup()
		expand_video_button.text = "Perkecil"
	else:
		popup.get_child(0).remove_child(video_container)
		third_column.add_child(video_container)
		popup.hide()
		expand_video_button.text = "Perbesar"
	video_expanded = !video_expanded
