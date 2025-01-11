extends Node2D

const level_path = "res://level/"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition_to_level("start")
	SignalBus.change_level.connect(_on_change_level)
	SignalBus.reset_level.connect(_on_reset_level)
	

func transition_to_level(level_name: String):
	var path = "%s%s.tscn" % [level_path, level_name] 
	
	for node in $current_scene.get_children():
		node.queue_free()
	
	print('changing scene to '+ path)
	
	var node = load(path).instantiate()

	$current_scene.add_child(node)


func _on_change_level(level_name: String):
	transition_to_level(level_name)
	
func _on_reset_level():
	transition_to_level("test_1")
