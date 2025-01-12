extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$Label.show()


func _on_body_exited(body: Node2D) -> void:
	$Label.hide()
