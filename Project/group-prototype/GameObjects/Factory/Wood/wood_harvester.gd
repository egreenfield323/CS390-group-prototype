extends StaticBody2D

@export var generation_freq = 1.0  # Timer interval in seconds
@export var level = 1
@export var cost_to_upgrade = 200

var wood = {
	"name": "WOOD",
	"quantity": 1
}

var current_cart

func generate_cycle(cart):
	current_cart = cart
	
	$Timer.start(generation_freq)

func _on_timer_timeout() -> void:
	if current_cart and current_cart.inventory.size() < current_cart.max_inventory_space:
		current_cart.inventory.append(wood)
	else:
		$Timer.stop()
		current_cart.move_cart()
		current_cart = null

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		$UI.visible = !$UI.visible

func _on_level_upgrade_pressed() -> void:
	if $"../../..".currency >= cost_to_upgrade and level < 10:
		$"../../..".currency -= cost_to_upgrade
		level += 1
		generation_freq *= 0.8
		generation_freq = round(generation_freq*pow(10,2))/pow(10,2)
		cost_to_upgrade = roundi(cost_to_upgrade * 1.5)
		
		$UI/Upgrade_Menu/VBoxContainer/Level_Number.text = str(level)
		$UI/Upgrade_Menu/VBoxContainer/Generation_Number.text = "1 every " + str(generation_freq) + "s"
		$UI/Panel/VBoxContainer/Upgrade_Cost.text = "$" + str(cost_to_upgrade)
		
		if current_cart:
			$Timer.stop()
			$Timer.start(generation_freq)
