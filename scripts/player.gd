extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 75.0
const JUMP_VELOCITY = -350.0

var input_enabled: bool = true

func disable_input():
	input_enabled = false
	velocity = Vector2.ZERO
	set_physics_process(false) # congela o personagem

func enable_input():
	input_enabled = true
	set_physics_process(true) # descongela


func _physics_process(delta: float) -> void:
	if not input_enabled:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		anim.flip_h = true
	elif direction < 0:
		anim.flip_h = false

	move_and_slide()
