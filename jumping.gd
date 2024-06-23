extends State

class_name PlayerJumping

func handle_input(_delta):
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")

	# moving right while in air
	if right:
		player.velocity.x += run_acceleration * air_speed_coefficient
	# moving left while in air
	elif left:
		player.velocity.x -= run_acceleration * air_speed_coefficient
	# if long jump reduce gravity else apply gravity normally (idk if right place for applying gravity tbh)
	if jump and player.velocity.y < 0:
		player.velocity.y += (gravity*gravity_decay)*_delta
	else:
		player.velocity.y += gravity*_delta

func enter():
	player.velocity.y = jump_force
	sprite.play("jump")

func exit():
	pass

func update(_delta: float):
	super(_delta)
	if player.velocity.y >= 0:
		Transitioned.emit(self, "falling")

func physics_update(_delta: float):
	handle_input(_delta)
