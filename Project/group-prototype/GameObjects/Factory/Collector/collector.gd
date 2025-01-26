extends StaticBody2D

@export var level = 1
@export var offload_rate = 0.5
@export var cost_to_upgrade = 100

var current_cart
var collector_queue = []
var offloading = false

func add_to_collector_queue(cart):
	collector_queue.append(cart)
	offload_items()

func offload_items():
	if not offloading and collector_queue.size() > 0:
		offloading = true
		current_cart = collector_queue.pop_front()
		$Timer.start(offload_rate)

func _on_timer_timeout() -> void:
	if current_cart and current_cart.inventory.size() > 0:
		var item = current_cart.inventory.pop_front()
		$"../../..".add_to_inventory(item)
	else:
		$Timer.stop()
		current_cart.move_cart()
		current_cart = null
		offloading = false
		offload_items()

func _on_level_upgrade_pressed() -> void:
	if $"../../..".currency >= cost_to_upgrade and level < 10:
		$"../../..".sub_currency(cost_to_upgrade)
		level += 1
		offload_rate *= 0.7
		offload_rate = round(offload_rate*pow(10,2))/pow(10,2)
		cost_to_upgrade = roundi(cost_to_upgrade * 1.5)
		
		$UI/Upgrade_Menu/VBoxContainer/Level_Number.text = str(level)
		$UI/Upgrade_Menu/VBoxContainer/Offload_Number.text = str(offload_rate) + "/s"
		$UI/Panel/VBoxContainer/Upgrade_Cost.text = "$" + str(cost_to_upgrade)
		
		if offloading:
			$Timer.stop()
			$Timer.start(offload_rate)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		$UI.visible = !$UI.visible
