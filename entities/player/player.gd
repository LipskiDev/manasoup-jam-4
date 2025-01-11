extends CharacterBody2D

var shit_scene = preload("res://entities/pickups/shit.tscn")

var SPEED_MAX = 300.0
var CURRENT_SPEED = SPEED_MAX

var JUMP_MAX: float = -360
var JUMP_VELOCITY: float = JUMP_MAX
var direction = 0

var current_fruits : int = 0:
	set(value):
		current_fruits = value
		update_sprite()
		
var can_shit = true

@export var stage0: AnimatedSprite2D
@export var stage1: AnimatedSprite2D
@export var stage2: AnimatedSprite2D
@export var stage3: AnimatedSprite2D
@export var stage4: AnimatedSprite2D

var sprite: AnimatedSprite2D

func _init() -> void:
	update_jump_strength()
	
func _ready() -> void:
	SignalBus.fruit_eaten.connect(_on_fruit_eaten)
	SignalBus.trapdoor_entered.connect(_on_trapdoor_entered)
	SignalBus.finish_entered.connect(_on_finish_entered)
	SignalBus.finished.connect(_on_finished)
	sprite = stage0
	sprite.show()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.animation = "jump"
		sprite.play()
		
	if Input.is_action_just_pressed("increase_apple"):
		current_fruits += 1
		update_jump_strength()
	if Input.is_action_just_pressed("decrease_apple") && current_fruits > 0:
		current_fruits -= 1
		update_jump_strength()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if is_on_floor():
		direction = Input.get_axis("ui_left", "ui_right")
	else:
		direction = direction * 15/16 + Input.get_axis("ui_left", "ui_right") / 16
	
	if direction:
		velocity.x = direction * CURRENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 50)
	
	move_and_slide()
	
	
	# Animation Sachen
	if abs(velocity.x) > 0 and is_on_floor():
		sprite.animation = "walk"
		sprite.play()
	if velocity.length() == 0:
		sprite.stop()
		
	
	if velocity.x > 0:
		$Sprite.scale.x = 1
	elif velocity.x < 0:
		$Sprite.scale.x = -1
	
	
	
	# shitting
	if Input.is_action_just_pressed("shit"):
		if current_fruits > 0 && can_shit:
			shit()
			


func update_jump_strength() -> void:
	if current_fruits == 0:
		CURRENT_SPEED = SPEED_MAX
	elif current_fruits == 1:
		CURRENT_SPEED = SPEED_MAX / 1.2
	else:
		CURRENT_SPEED = SPEED_MAX / current_fruits * 1.5
	
	if current_fruits == 0:
		JUMP_VELOCITY = JUMP_MAX
	elif current_fruits == 1:
		JUMP_VELOCITY = JUMP_MAX / 1.2
	else:
		JUMP_VELOCITY = JUMP_MAX / current_fruits * 1.5

func update_sprite():
	sprite.hide()
	match current_fruits:
		0:
			sprite = stage0
		1:
			sprite = stage1
		2:
			sprite = stage2
		3:
			sprite = stage3
		4:
			sprite = stage4
		_:
			print("HURENSOHN")
	
	sprite.show()

func shit():
	current_fruits -= 1
	update_jump_strength()
	var shit = shit_scene
	var instance = shit.instantiate()
	instance.position = $Sprite/Ass.global_position
	$"..".add_child(instance)
# Signals

func _on_fruit_eaten():
	current_fruits += 1
	update_jump_strength()
	SignalBus.current_weight.emit(current_fruits)
	
func _on_trapdoor_entered():
	SignalBus.weight_on_trapdoor.emit(current_fruits)
	
func _on_finish_entered():
	SignalBus.current_weight.emit(current_fruits)
	
func _on_finished():
	sprite.hide()
