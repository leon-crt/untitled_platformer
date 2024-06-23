extends Node

class_name State

signal Transitioned

@onready var sprite = $AnimatedSprite2D

@export var run_acceleration = 60
@export var air_speed_coefficient = 0.5
@export var ground_friction = 2000
@export var jump_force = -1000
@export var slide_boost = 200
@export var gravity = 4000
@export var gravity_decay = 0.5
@export var MAX_SPEED_X = 600
@export var MAX_SPEED_Y = 1000

@onready var player : CharacterBody2D = $player

func adjust_horizontal_speed():
	match player.velocity.x:
		var x when x > MAX_SPEED_X:
			player.velocity.x = MAX_SPEED_X
		var x when player.velocity.x < MAX_SPEED_X * -1:
			player.velocity.x = MAX_SPEED_X * -1

func handle_input(_delta: float):
	pass

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	if player.velocity.x * sprite.scale.x < 0:
			sprite.scale.x *= -1

func physics_update(_delta: float):
	handle_input(_delta)
	adjust_horizontal_speed()
	player.velocity.y += gravity*_delta
