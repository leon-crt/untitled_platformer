extends State

func handle_input(_delta):
	var jump = Input.is_action_just_pressed("jump")
	var crouch = Input.is_action_just_pressed("slide")
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	
	if jump:
		player.velocity.y = jump_force # move this in Enter() of jump state?
		Transitioned.emit(self, "jumping")
	if right:
		player.velocity.x += run_acceleration
	# moving left while running
	elif left:
		player.velocity.x -= run_acceleration
	if crouch:
		Transitioned.emit(self, "sliding")

func enter():
	sprite.play("run")

func update(_delta: float):
	super(_delta)
	if player.velocity.x < 10:
		Transitioned.emit(self, "idle")

func physics_update(_delta):
	super(_delta)
	#apply ground friction
	if player.velocity.x > 0:
		player.velocity.x -= ground_friction * _delta
		#if player.velocity.x < 0:
			#player.velocity.x = 0
	elif player.velocity.x < 0:
		player.velocity.x += ground_friction * _delta
		#if player.velocity.x > 0:
			#player.velocity.x = 0
