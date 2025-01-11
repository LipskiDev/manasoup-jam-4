class_name Fruit extends Pickup

var frames
signal gets_eaten

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frames = $Sprite2D.texture.get_width() / $Sprite2D.region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	$Sprite2D.region_rect.position.x = random_index * $Sprite2D.region_rect.size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	gets_eaten.emit()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	gets_eaten.emit()
	queue_free()
