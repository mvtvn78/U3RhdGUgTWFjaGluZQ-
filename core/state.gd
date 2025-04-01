extends Node
# Define Abstract State Class
class_name State
# Define owner state machine
var object 
# Define finite state machine
var fsm
# Enter State
func enter():
	pass
# Update State
func update(_delta):
	pass
# Handle Physic 
func physics_update(_delta):
	pass
# Exit State
func exit():
	pass
# Change State
func change_state(next_state):
	fsm.change_state(next_state)
