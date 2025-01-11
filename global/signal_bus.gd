extends Node

signal fruit_eaten

signal trapdoor_entered
signal weight_on_trapdoor(weight)
signal current_weight(weight)
signal change_level(name: String) # just the name e.g. "test_level"
signal finish_entered
signal finished #when worg is on finished and obese enough
signal reset_level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
