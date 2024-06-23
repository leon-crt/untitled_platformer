extends State

@onready var crouching_hbox: CollisionShape2D = $crouching_hitbox
@onready var standing_hbox: CollisionShape2D = $standing_hitbox

func handle_input(_delta: float):
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	
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

func enter():
	sprite.play("crouch")
	crouching_hbox.disabled = false
	standing_hbox.disabled = true

func exit():
	crouching_hbox.disabled = true
	standing_hbox.disabled = false
