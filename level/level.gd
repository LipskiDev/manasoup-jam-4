class_name Level extends Node2D

@export var next_scene_name: String
var all_fruits_eaten = false

var eaten_fruits = 0

func _ready() -> void:
	SignalBus.fruit_eaten.connect(_on_fruit_eaten)


func _on_fruit_eaten():
	eaten_fruits += 1
	print($Fruits.get_children())
	if($Fruits.get_child_count() -1 == 0):
		SignalBus.change_level.emit(next_scene_name)
		#TODO set all_fruits_eaten to true and listen to "finishing_area_entered" before changing level
