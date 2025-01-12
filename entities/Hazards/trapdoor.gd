extends Area2D

@export var max_weight: int = 1
var stepped_on = false
@export var one_way: bool = true
var ypos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.weight_on_trapdoor.connect(_on_weight_on_trapdoor)
	$StaticBody2D/CollisionShape2D.one_way_collision = one_way
	ypos = position.y

func _on_body_entered(body: Node2D) -> void:
	stepped_on = true
	SignalBus.trapdoor_entered.emit()
		
func _on_body_exited(body: Node2D) -> void:
	stepped_on = false


func _on_weight_on_trapdoor(weight):
	if weight > max_weight:
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.region_rect.position.y = 16
		$Sprite2D.region_rect.size.y = 32
		position.y = ypos + 8
