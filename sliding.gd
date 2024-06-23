extends State

@onready var crouching_hbox: CollisionShape2D = $crouching_hitbox
@onready var standing_hbox: CollisionShape2D = $standing_hitbox
@export var slide_friction = 2000

func handle_input(_delta: float):
	pass

func enter():
	sprite.play("slide")
	player.velocity.x += 200
	crouching_hbox.disabled = false
	standing_hbox.disabled = true

func exit():
	crouching_hbox.disabled = true
	standing_hbox.disabled = false

func update(_delta: float):
	super(_delta)
	if player.velocity.x < 10:
		if Input.is_action_pressed("crouch"):
			Transitioned.emit(self, "crouching")
		else:
			Transitioned.emit(self, "idle")

func physics_update(_delta: float):
	super(_delta)
	#apply ground friction
	if player.velocity.x > 0:
		player.velocity.x -= slide_friction * _delta
		#if player.velocity.x < 0:
			#player.velocity.x = 0
	elif player.velocity.x < 0:
		player.velocity.x += slide_friction * _delta
		#if player.velocity.x > 0:
			#player.velocity.x = 0
