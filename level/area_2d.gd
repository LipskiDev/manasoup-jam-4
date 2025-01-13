extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$Timer.start()
	
	
func _on_timer_timeout():
	$Sprite2D.hide()
	$CollisionShape2D.disabled = true
	$AudioStreamPlayer2D.play()
	$Sprite2D2.show()
