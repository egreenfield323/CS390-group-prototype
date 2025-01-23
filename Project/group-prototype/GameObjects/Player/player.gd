extends CharacterBody2D

@export var CLONE_RESOURCE: Resource

@export var SPEED = 300.0
@onready var clone_timer = $CloneTimer
@export var CLONES_NODE: Node

func _physics_process(delta: float) -> void:
	var direction: Vector2
	
	if Input.is_action_pressed("move_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		direction += Vector2.RIGHT
	if Input.is_action_pressed("move_up"):
		direction += Vector2.UP
	if Input.is_action_pressed("move_down"):
		direction += Vector2.DOWN
	
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("clone"):
		make_clone()

#TODO: Come back here and add resource cost to clone
func make_clone():
	if clone_timer.time_left > 0:
		return
	
	var clone = CLONE_RESOURCE.instantiate()
	clone.position = self.global_position
	CLONES_NODE.add_child(clone)
	
	clone_timer.start()
