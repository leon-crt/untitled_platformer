extends State

class_name PlayerJumping

func enter():
	player.velocity.y = jump_force
	sprite.play("jump")

func exit():
	pass

func update(_delta: float):
	if player.velocity.y >= 0:
		Transitioned.emit(self, "falling")

func physics_update(_delta: float):
	if Input.is_action_pressed("jump") and player.velocity.y < 0:
		player.velocity.y += (gravity*gravity_decay)*_delta
	else:
		player.velocity.y += gravity*_delta
