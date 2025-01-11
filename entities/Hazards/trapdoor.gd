extends Area2D

@export var max_weight: int = 1
var stepped_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.weight_on_trapdoor.connect(_on_weight_on_trapdoor)


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
