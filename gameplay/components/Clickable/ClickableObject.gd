extends Area2D
class_name ClickableObject

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		on_click()
		
func on_click():
	print("clicked")
