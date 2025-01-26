extends Node2D

# Exported variables
@export var max_inventory_space = 20
@export var cost_to_upgrade = 100
@export var distance_along_path = 0
@export var cart = ""
@export var level = 1

# Internal variables
var inventory = []
var hovering_over_ui = false
@onready var label = $Area2D/Label
var previous_inventory_size: int = 0

# Cart-related functions
func move_cart():
	var animation = _get_cart()
	$AnimationPlayer.play(animation)

func _get_cart() -> String:
	var animation = ""
	match cart:
		"WOOD_01":
			animation = "WOOD_01_" + (_get_direction())
		"WOOD_02":
			animation = "WOOD_02_" + (_get_direction())
		"WOOD_03":
			animation = "WOOD_03_" + (_get_direction())
		"STONE_01":
			animation = "STONE_01_" + (_get_direction())
		"STONE_02":
			animation = "STONE_02_" + (_get_direction())
	return animation

func _get_direction() -> String:
	return "FORWARD" if distance_along_path == 0 else "BACKWARDS"

# Initialization functions
func _ready() -> void:
	match cart:
		"WOOD_01":
			$Area2D.position = Vector2(312, 150)
		"WOOD_02":
			$Area2D.position = Vector2(376, 150)
		"WOOD_03":
			$Area2D.position = Vector2(440, 150)
		"STONE_01":
			$Area2D.position = Vector2(377, 53)
			$Area2D/Sprite2D.frame = 54
		"STONE_02":
			$Area2D.position = Vector2(424, 101)

# Inventory-related functions
func _process(delta: float) -> void:
	if inventory.size() != previous_inventory_size:
		$Area2D/Label.text = str(inventory.size())
		previous_inventory_size = inventory.size()

# Collision detection functions
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Harvester") and body.name.ends_with(cart):
		body.generate_cycle(self)
	elif body.name.begins_with("Collector"):
		var index = cart.find("_")
		if body.name.contains(cart.substr(0, index)):
			body.add_to_collector_queue(self)

# UI hover functions
func _on_area_2d_mouse_entered() -> void:
	if not hovering_over_ui:
		label.visible = true

func _on_area_2d_mouse_exited() -> void:
	label.visible = false

# UI click interaction functions
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		hovering_over_ui = !hovering_over_ui
		$Area2D/UI.visible = !$Area2D/UI.visible
		label.visible = not hovering_over_ui

# Level upgrade function
func _on_level_upgrade_pressed() -> void:
	if $"../../..".currency >= cost_to_upgrade and level < 5:
		$"../../..".sub_currency(cost_to_upgrade)
		level += 1
		max_inventory_space = roundi(max_inventory_space * 1.5)
		cost_to_upgrade = roundi(cost_to_upgrade * 1.4)
		
		$Area2D/UI/Upgrade_Menu/VBoxContainer/Level_Number.text = str(level)
		$Area2D/UI/Upgrade_Menu/VBoxContainer/Inventory_Number.text = str(max_inventory_space)
		$Area2D/UI/Panel/VBoxContainer/Upgrade_Cost.text = "$" + str(cost_to_upgrade)
