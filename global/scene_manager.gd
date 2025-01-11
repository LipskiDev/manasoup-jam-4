extends Node2D

const level_path = "res://level/level"
var level_idx = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start with level0
	load_level(level_idx)
	SignalBus.next_level.connect(_on_next_level)
	SignalBus.reset_level.connect(_on_reset_level)
	

	
func load_level(level_name: int):
	
	var path = "%s%s.tscn" % [level_path, level_name] 
	
	for node in $current_scene.get_children():
		node.queue_free()
	
	print('changing scene to '+ path)
	
	var node = load(path).instantiate()

	$current_scene.add_child(node)

func next_level():
	level_idx += 1
	load_level(level_idx)
	
	
func _on_prev_level():
	level_idx -= 1
	load_level(level_idx)
	

func _on_next_level():
	next_level()
	
func _on_reset_level():
	print("ResetLevel")
	load_level(level_idx)
	
