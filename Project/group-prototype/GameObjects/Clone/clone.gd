extends RigidBody2D

var enemies_in_view = []
var looking = false

func _process(delta: float) -> void:
	if check_looking():
		look_at(enemies_in_view[0].global_position)

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
