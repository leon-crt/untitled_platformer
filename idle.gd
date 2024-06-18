extends State
class_name PlayerIdle

func handle_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var crouch = Input.is_action_just_pressed("slide")
	
	if jump:
		player.velocity.y = jump_force # move this in Enter() of jump state?
		Transitioned.emit(self, "jumping")
	# moving right while grounded
	elif right:
		player.velocity.x += run_acceleration
		Transitioned.emit(self, "running")
	# moving left while running
	elif left:
		player.velocity.x -= run_acceleration
		Transitioned.emit(self, "running")
	if crouch:
		Transitioned.emit(self, "crouching")
# Called when the node enters the scene tree for the first time.
func enter():
	sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input()
