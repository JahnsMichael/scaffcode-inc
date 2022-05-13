extends Node2D

export var use_background_as_boundary: bool

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var boundary : Rect2
	if use_background_as_boundary:
		boundary = $BackgroundSprite.get_rect()
		$BoundarySprite.visible = false
	else:
		boundary = $BoundarySprite.get_rect()

	$MousePointer/Camera2D.set_limit(0, boundary.position.x)
	$MousePointer/Camera2D.set_limit(1, boundary.position.y)
	$MousePointer/Camera2D.set_limit(2, boundary.end.x)
	$MousePointer/Camera2D.set_limit(3, boundary.end.y)
	
	print(boundary.position)
	print(boundary.end)
	start_dialog()
	
func start_dialog():
	var dialog = Dialogic.start("Advi-First Time")
	dialog.pause_mode = PAUSE_MODE_PROCESS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.add_child(dialog)
	dialog.connect("timeline_end", self, "end_dialog")
	get_tree().paused = true

func end_dialog(data):
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
