extends LinkButton

signal reset_button_pressed()

func _on_Reset_pressed():
	emit_signal("reset_button_pressed")
