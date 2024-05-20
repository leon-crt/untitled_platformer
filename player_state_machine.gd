extends Node

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(on_child_transition)

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
