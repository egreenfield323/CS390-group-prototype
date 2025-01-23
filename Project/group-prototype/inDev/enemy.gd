extends CharacterBody2D
var speed= 120
var direction = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction *speed
	move_and_slide()
	
func moveUp():
	direction = Vector2.UP
func moveDown():
	direction = Vector2.DOWN
func moveRight():
	direction = Vector2.RIGHT
func moveLeft():
	
	direction = Vector2.LEFT
	
func getDirection():
	return direction
