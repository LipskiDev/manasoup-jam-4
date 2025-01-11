extends CanvasLayer

@export var fruit_label: Label
var fruits: int = 0

func _ready() -> void:
	fruit_label.text = "Fruits: 0"
	SignalBus.fruit_eaten.connect(update_fruit_label)

func update_fruit_label():
	fruits = fruits + 1
	fruit_label.text = "Fruits: " + str(fruits)
	fruit_label.show()


func _on_start_button_pressed() -> void:
	$MarginContainer.hide()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
