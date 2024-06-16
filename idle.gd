extends State
class_name PlayerIdle

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter():
	sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
