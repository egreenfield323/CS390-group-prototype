extends RigidBody2D

@export var BULLET_RESOURCE: Resource
@onready var BULLET_NODE = $Bullets
@onready var SHOOT_TIMER = $ShootTimer

var enemies_in_view = []
var looking = false


func _process(delta: float) -> void:
	if check_looking():
		look_at(enemies_in_view[0].global_position)
		shoot_bullet()

func _on_clone_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		enemies_in_view.append(body)

func _on_clone_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		enemies_in_view.erase(body)

func check_looking():
	if enemies_in_view.is_empty():
		return false
	
	return true

func shoot_bullet():
	if SHOOT_TIMER.time_left <= 0:
		var bullet = BULLET_RESOURCE.instantiate()
		bullet.position = get_parent().global_position
		bullet.direction = (self.global_position - enemies_in_view[0].global_position).normalized()
		BULLET_NODE.add_child(bullet)
		SHOOT_TIMER.start()
