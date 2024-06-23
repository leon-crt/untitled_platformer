extends State

func handle_input(delta):
	var left = Input.is_action_just_pressed("left")
	var right = Input.is_action_just_pressed("right")
	
	# moving right while in air
	if right:
		player.velocity.x += run_acceleration * air_speed_coefficient
	# moving left while in air
	elif left:
		player.velocity.x -= run_acceleration * air_speed_coefficient

func enter():
	sprite.play("falling")

func exit():
	pass

func update(_delta: float):
	super(_delta)
	if player.is_on_floor():
		Transitioned.emit(self, "idle")

func physics_update(_delta: float):
	handle_input(_delta)
	player.velocity.y += gravity*_delta

