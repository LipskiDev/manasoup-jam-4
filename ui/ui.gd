extends CanvasLayer

@export var fruit_label: Label

func _ready() -> void:
	fruit_label.text = "Fruits: 0"
	SignalBus.current_weight.connect(update_fruit_label)

func update_fruit_label(text):
	fruit_label.text = "Fruits: " + str(text)
	fruit_label.show()


func _on_start_button_pressed() -> void:
	$MarginContainer.hide()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
