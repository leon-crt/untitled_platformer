extends CharacterBody2D

@export var run_acceleration = 60
@export var air_speed_coefficient = 0.5
@export var ground_friction = 2000
@export var jump_force = -1000
@export var slide_boost = 200
@export var gravity = 4000
@export var gravity_decay = 0.5
@export var MAX_SPEED_X = 600
@export var MAX_SPEED_Y = 1000

@onready var sprite = $AnimatedSprite2D
@onready var screen_size = get_viewport_rect().size

var jumping = false

func adjust_horizontal_speed():
	match velocity.x:
		var x when x > MAX_SPEED_X:
			velocity.x = MAX_SPEED_X
		var x when velocity.x < MAX_SPEED_X * -1:
			velocity.x = MAX_SPEED_X * -1

func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var crouch = Input.is_action_just_pressed("slide")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_force
	# moving right while in the air
	if right and !is_on_floor():
		velocity.x += run_acceleration * air_speed_coefficient
	# moving right while running
	elif right:
		velocity.x += run_acceleration
	# moving left while in the air
	if left and !is_on_floor():
		velocity.x -= run_acceleration * air_speed_coefficient
	# moving left while running
	elif left:
		velocity.x -= run_acceleration

func anim_handler():
	match [velocity.x, velocity.y]:
		[var x, _] when x * sprite.scale.x < 0:
			sprite.scale.x *= -1
		[var x, var y] when x != 0 and is_on_floor():
			sprite.play("run")
		[_, var y] when y < 0 and jumping:
			sprite.play("jump")
		[_, var y] when y >= 0 and !is_on_floor():
			sprite.play("fall")
		_:
			sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jumping and is_on_floor():
		jumping = false
	get_input()
	# apply gravity (super jumping makes gravity less intense when going up)
	if Input.is_action_pressed("jump") and jumping and velocity.y < 0:
		velocity.y += (gravity*gravity_decay)*delta
	else:
		velocity.y += gravity*delta
	# apply ground friction
	if velocity.x > 0 and !jumping:
		velocity.x -= ground_friction * delta
		if velocity.x < 0:
			velocity.x = 0
	elif velocity.x < 0 and !jumping:
		velocity.x += ground_friction * delta
		if velocity.x > 0:
			velocity.x = 0
	# approximate velocity so that character doesn't go over max speed
	adjust_horizontal_speed()
	# handle animations
	anim_handler()
	
	move_and_slide()
