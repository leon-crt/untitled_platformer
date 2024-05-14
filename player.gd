extends CharacterBody2D

@export var run_speed = 450
@export var jump_force = -600
@export var gravity = 1200

var screen_size
var jumping = false

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_force
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

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
	velocity.y += gravity*delta
	anim_handler()
	
	move_and_slide()
