extends CharacterBody2D

@export var SPEED: float = 2.0

func _process(_delta: float) -> void:
	get_parent().progress += SPEED
