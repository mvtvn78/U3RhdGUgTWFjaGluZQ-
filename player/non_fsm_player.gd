extends CharacterBody2D

const ACCEL = 1000.0
const TOP_SPEED = Vector2(90, 90)

@onready var sprite = $AnimatedSprite2D
@onready var input = InputManager.new()
var facing = Vector2.RIGHT :
	get: return facing
	set(value):
		if value == Vector2.ZERO: return
		facing = value
		sprite.flip_h = value.x == -1

var moving = false
var attacking = false
var combo = false

func _physics_process(delta):
	input.update(delta)
	var has_movement_input = input.normalized != Vector2.ZERO
	if not attacking and input.attack:
		_attack()
	elif not moving and not attacking and has_movement_input:
		sprite.play("run")
		moving = true
	elif not attacking and not has_movement_input:
		sprite.play("idle")
		moving = false
	
	if moving:
		velocity = velocity.move_toward(TOP_SPEED * input.normalized, ACCEL * delta)
		facing = input.raw
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCEL * delta)
	
	move_and_slide()

func _attack():
	moving = false
	attacking = true
	input.attack = false
	facing = input.attack_direction
	var anim_dir = "side"
	if facing.y != 0:
		anim_dir = "down" if facing.y == 1 else "up"
	sprite.play("attack_%s_%d" % [anim_dir, 2 if combo else 1])
	combo = not combo

func _on_animation_finished():
	if attacking:
		if input.attack:
			_attack()
		else:
			attacking = false
			combo = false
