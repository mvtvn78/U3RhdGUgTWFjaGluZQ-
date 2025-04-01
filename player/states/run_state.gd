# Implement State
extends State

func enter():
	object.sprite.play("run")

func physics_update(delta):
	object.velocity = object.velocity.move_toward(object.TOP_SPEED * object.input.normalized, object.ACCEL * delta)
	object.facing = object.input.raw
	object.move_and_slide()
	if object.input.attack:
		change_state("attack")
	elif object.input.raw == Vector2.ZERO:
		change_state("idle")
