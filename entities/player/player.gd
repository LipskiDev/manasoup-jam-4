extends CharacterBody2D


var SPEED_MAX = 300.0
var CURRENT_SPEED = SPEED_MAX

var JUMP_MAX = -400
var JUMP_VELOCITY = JUMP_MAX

var current_fruits : int = 0

@export var stage0: AnimatedSprite2D
@export var stage1: AnimatedSprite2D

var sprite: AnimatedSprite2D

func _init() -> void:
	update_jump_strength()
	
func _ready() -> void:
	SignalBus.fruit_eaten.connect(_on_fruit_eaten)
	sprite = stage0


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
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * CURRENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, CURRENT_SPEED)
	move_and_slide()
	
	
	# Animation Sachen
	if abs(velocity.x) > 0 and is_on_floor():
		sprite.animation = "walk"
		sprite.play()
	if velocity.length() == 0:
		sprite.stop()
		
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0


func update_jump_strength() -> void:
	if current_fruits == 0:
		CURRENT_SPEED = SPEED_MAX
	elif current_fruits == 1:
		CURRENT_SPEED = SPEED_MAX / 1.5
	else:
		CURRENT_SPEED = SPEED_MAX / current_fruits
	
	if current_fruits == 0:
		JUMP_VELOCITY = JUMP_MAX
	elif current_fruits == 1:
		JUMP_VELOCITY = JUMP_MAX / 1.5
	else:
		JUMP_VELOCITY = JUMP_MAX / current_fruits

func _on_fruit_eaten():
	current_fruits += 1
	update_jump_strength()
