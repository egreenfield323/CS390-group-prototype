extends RigidBody2D

@export var SPEED : float = 500.0
@export var dmg_amount : int = 1

var direction

func _ready() -> void:
	linear_velocity = -1 * direction * SPEED
