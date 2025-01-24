extends StaticBody2D

@export var offload_rate = 0.1

var current_cart

@export var collector_queue = []

var offloading = false

func add_to_collector_queue(cart):
	collector_queue.append(cart)
	offload_items()

func offload_items():
	if not offloading:
		if collector_queue.size() > 0:
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
