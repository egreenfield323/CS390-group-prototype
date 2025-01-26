extends CharacterBody2D

@onready var sprite1 = $Sprite2D
@onready var sprite2 = $Sprite2D2
@onready var sprite3 = $Sprite2D3
@onready var sprite4 = $Sprite2D4
@onready var sprite5 = $Sprite2D5


@export var CLONE_RESOURCE1: Resource
@export var CLONE_RESOURCE2: Resource
@export var CLONE_RESOURCE3: Resource
@export var CLONE_RESOURCE4: Resource
@export var CLONE_RESOURCE5: Resource
@onready var cloneList = [CLONE_RESOURCE1, CLONE_RESOURCE2,CLONE_RESOURCE3,CLONE_RESOURCE4,CLONE_RESOURCE5]


@export var SPEED = 300.0
@onready var clone_timer = $CloneTimer
@export var CLONES_NODE: Node

@onready var curSprite = 0
@onready var spriteList = [sprite1,sprite2,sprite3,sprite4,sprite5]

func _physics_process(delta: float) -> void:
	check_Char()
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
	
#sprite switch depending on global var
func check_Char():
	if PlayerInfo.playerVer == curSprite:
		return
	for sprite in spriteList:
		sprite.hide()
	spriteList[PlayerInfo.playerVer -1].show()
		
	curSprite = PlayerInfo.playerVer
	

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
	
	var clone = cloneList[PlayerInfo.playerVer-1].instantiate()
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
