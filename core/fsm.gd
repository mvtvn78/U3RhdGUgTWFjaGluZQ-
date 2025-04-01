extends Node
#Store all states by dict
var states = {}
# tracking state
var current_state_node
var current_state
var previous_state

func _ready():
	# get Player object (parennt)
	var object = get_parent()
	#Loop through child node in FSM Node (Idle, Run, Attack )
	for child in get_children():
		#Check Type is State Class
		if child is State:
			#Store it in dict
			states[child.name.to_lower()] = child
			#Initialize variables
			child.object = object
			child.fsm = self
func update(delta):
	if not current_state_node: return
	current_state_node.update(delta)
#
func physics_update(delta):
	if not current_state_node: return
	current_state_node.physics_update(delta)
	
func change_state(next_state):
	# Clean up prev state
	if current_state_node:
		current_state_node.exit()
	# Tracking state
	previous_state = current_state
	current_state = next_state
	current_state_node = states[current_state]
	# Begin state and log 
	print_debug("States : " , next_state)
	current_state_node.enter() 
