extends RigidBody2D

@export var BULLET_RESOURCE: Resource
#@onready var BULLET_NODE = $Bullets
@onready var LASER_POINT = $LaserPoint

@onready var SHOOT_TIMER = $ShootTimer
@onready var LASER_DUR = $LaserDuration

var enemies_in_view = []
var looking = false


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if check_looking():
		look_at(enemies_in_view[0].global_position)
		shoot_laser()
	shoot_laser()

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
	
func shoot_laser():
	if SHOOT_TIMER.time_left <= 0:
		LASER_POINT.add_point(enemies_in_view[0].get_position)
		
		LASER_DUR.start()
		enemies_in_view[0].die()
		SHOOT_TIMER.start()
		

func _on_laser_duration_timeout() -> void:
	if LASER_POINT.get_point_count() > 0:
		LASER_POINT.remove_point(1)
		
