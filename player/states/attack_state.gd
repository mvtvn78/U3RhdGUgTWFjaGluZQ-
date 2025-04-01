extends State

var combo = false
var connected = false

func enter():
	if not connected:
		object.sprite.animation_finished.connect(_on_animation_finished)
		connected = true
	object.input.attack = false
	object.facing = object.input.attack_direction
	var anim_dir = "side"
	if object.facing.y != 0:
		anim_dir = "down" if object.facing.y == 1 else "up"
	object.sprite.play("attack_%s_%d" % [anim_dir, 2 if combo else 1])
	combo = not combo

func physics_update(delta):
	object.velocity = object.velocity.move_toward(Vector2.ZERO, object.ACCEL * delta)
	object.move_and_slide()

func _on_animation_finished():
	if object.input.attack:
		enter()
	else:
		combo = false
		if object.input.raw != Vector2.ZERO:
			change_state("run")
		else:
			change_state("idle")

func exit():
	object.sprite.animation_finished.disconnect(_on_animation_finished)
	connected = false
