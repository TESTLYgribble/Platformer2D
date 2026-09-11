extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity: float = 500.0
var jump_velocity: float = -200.0
var move_speed: float = 120.0 
var spawn_position: Vector2

func _ready() -> void:
	player_sprite.play("Idle")
	spawn_position = global_position

func _physics_process(delta: float) -> void:
	# Out of bounds reset
	if global_position.y >= 180.0:
		global_position = spawn_position
		velocity = Vector2.ZERO 

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * move_speed
		player_sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
