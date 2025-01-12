extends Area2D

@export var fruit_goal = 1
var stepped_on = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.current_weight.connect(_on_current_weight)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	stepped_on = true
	SignalBus.finish_entered.emit()
	
func _on_body_exited(body: Node2D) -> void:
	stepped_on = false
	
func _on_current_weight(weight):
	if weight >= fruit_goal && stepped_on == true:
		print("verpupp")
		SignalBus.finished.emit()
		$Sprite2D.region_rect.position.x = 64
		$FinishTimer.start()
		


func _on_finish_timer_timeout() -> void:
	print("timer_finished")
	SignalBus.next_level.emit()
