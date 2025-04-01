class_name InputManager

var x
var y
var normalized
var raw

var attack :
	get:
		return attack_timer >= 0
	set(value):
		attack_timer = .2 if value else -1
			
var attack_direction
var attack_timer = -1

func update(delta):
	if attack_timer > 0:
		attack_timer -= delta
	
	x = Input.get_axis("ui_left", "ui_right")
	y = Input.get_axis("ui_up", "ui_down")
	raw = Vector2(x, y)
	normalized = raw.normalized()
	
	if Input.is_action_just_pressed("ui_accept"):
		attack = true
		attack_direction = raw
