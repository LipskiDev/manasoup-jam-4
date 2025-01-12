extends CanvasLayer

func _ready() -> void:
	pass
	
func _on_start_button_pressed() -> void:
	$MarginContainer.hide()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
