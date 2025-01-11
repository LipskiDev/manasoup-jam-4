extends Area2D

@export var max_weight: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.current_weight.connect(_on_current_weight)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	SignalBus.trapdoor_entered.emit()

func _on_current_weight(weight):
	if weight > max_weight:
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.region_rect.position.y = 16
		$Sprite2D.region_rect.size.y = 32
