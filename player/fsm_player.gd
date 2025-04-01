# Object owner FSM
extends CharacterBody2D

const ACCEL = 1000.0
const TOP_SPEED = Vector2(90, 90)
# Intialize needed variables 
@onready var fsm = $FSM
@onready var sprite = $AnimatedSprite2D
@onready var input = InputManager.new()
var facing = Vector2.RIGHT :
	get: return facing
	set(value):
		if value == Vector2.ZERO: return
		facing = value
		sprite.flip_h = value.x == -1

func _ready():
	fsm.change_state("idle")

func _process(delta):
	fsm.update(delta)

func _physics_process(delta):
	input.update(delta)
	fsm.physics_update(delta)
