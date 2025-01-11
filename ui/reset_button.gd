extends Button

var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $AnimatedSprite2D

func _on_button_up():
	sprite.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	SignalBus.reset_level.emit()


func _on_button_down() -> void:
	sprite.play()
