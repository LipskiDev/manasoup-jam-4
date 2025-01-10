extends Node

@export var start_button: Button
@export var exit_button: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	start_button.hide()


func _on_exit_button_pressed() -> void:
	exit_button.hide()
