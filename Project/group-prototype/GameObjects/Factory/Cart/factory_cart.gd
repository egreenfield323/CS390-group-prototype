extends Node2D

var inventory = []
var max_inventory_space = 20

@export var distance_along_path = 0

@export var cart = ""

@onready var label = $Area2D/Label

func move_cart():
	var animation = _get_cart()
	
	$AnimationPlayer.play(animation)

func _get_cart():
	var animation = ""
	match cart:
		"WOOD_01":
			if distance_along_path == 0:
				animation = "WOOD_01_FORWARD"
			else:
				animation = "WOOD_01_BACKWARDS"
		"WOOD_02":
			if distance_along_path == 0:
				animation = "WOOD_02_FORWARD"
			else:
				animation = "WOOD_02_BACKWARDS"
		"WOOD_03":
			if distance_along_path == 0:
				animation = "WOOD_03_FORWARD"
			else:
				animation = "WOOD_03_BACKWARDS"
	return animation

func _ready() -> void:
	match cart:
		"WOOD_01":
			$Area2D.position = Vector2(312, 150)
		"WOOD_02":
			$Area2D.position = Vector2(376, 150)
		"WOOD_03":
			$Area2D.position = Vector2(440, 150)
	pass


var previous_inventory_size: int = 0

func _process(delta: float) -> void:
	if inventory.size() != previous_inventory_size:
		$Area2D/Label.text = str(inventory.size())
		previous_inventory_size = inventory.size()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Wood_Harvester"):
		body.generate_cycle(self)
	elif body.name.begins_with("Collector"):
		body.add_to_collector_queue(self)


func _on_area_2d_mouse_entered() -> void:
	label.visible = true


func _on_area_2d_mouse_exited() -> void:
	label.visible = false
