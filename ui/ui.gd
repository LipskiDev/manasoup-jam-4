extends CanvasLayer

@export var fruit_label: Label

func change_fruit_label(text):
	fruit_label.text = "Fruits needed: " + text
	fruit_label.show()
