extends CharacterBody2D

@export var CLONE_RESOURCE: Resource

@export var SPEED = 300.0
@onready var clone_timer = $CloneTimer
@export var CLONES_NODE: Node

func _physics_process(delta: float) -> void:
	var direction: Vector2
	
	if Input.is_action_pressed("move_left"):
		direction += Vector2.LEFT
		look_left()
	if Input.is_action_pressed("move_right"):
		direction += Vector2.RIGHT
		look_right()
	if Input.is_action_pressed("move_up"):
		direction += Vector2.UP
		look_up()
	if Input.is_action_pressed("move_down"):
		direction += Vector2.DOWN
		look_down()
	
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("clone"):
		make_clone()

#TODO: Come back here and add resource cost to clone
func make_clone():
	if clone_timer.time_left > 0:
		return
	
	if CLONES_NODE == null:
		print("ERROR: No node specified for variable CLONES_NODE!!!")
		CLONES_NODE = self
	
	var clone = CLONE_RESOURCE.instantiate()
	clone.position = self.global_position
	CLONES_NODE.add_child(clone)
	
	clone_timer.start()

func look_up():
	global_rotation_degrees = 270
func look_down():
	global_rotation_degrees = 90
func look_left():
	global_rotation_degrees = 180
func look_right():
	global_rotation_degrees = 0
