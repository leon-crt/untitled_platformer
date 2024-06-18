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

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	#handle_input()
	pass

func physics_update(_delta: float):
	player.velocity.y += gravity*_delta
