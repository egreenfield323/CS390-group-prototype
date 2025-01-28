extends CharacterBody2D

@export var speed = 120
@export var health : int = 1
@export var level : int = 1
@export var worth : int = 5
@export var direction = Vector2.UP

var GLOBAL = GameController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match level:
		1:
			$ColorRect.color = Color(0.99, 0.19, 0.17, 1.0)
			health = 1
			speed = 120
			worth = 5
		2:
			$ColorRect.color = Color(0.0, 1.0, 1.0, 1.0)
			health = 2
			speed = 110
			worth = 10
		3:
			$ColorRect.color = Color(0.0, 0.76, 0.21, 1.0)
			health = 3
			speed = 125
			worth = 15
		4:
			$ColorRect.color = Color(0.84, 0.34, 0.83, 1.0)
			health = 5
			speed = 110
			worth = 30
		5:
			$ColorRect.color = Color(0.89, 0.49, 0.21, 1.0)
			health = 10
			speed = 90
			worth = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_health()

func _physics_process(delta: float) -> void:
	velocity = direction * speed
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

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name.match("Bullet"):
		body.queue_free()
		health -= body.dmg_amount

func check_health():
	if health <= 0:
		die()

func die():
	self.queue_free()
	GLOBAL.currency += worth
	get_parent().get_parent().update_currency_label()
