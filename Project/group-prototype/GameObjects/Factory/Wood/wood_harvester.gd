extends StaticBody2D

@export var generation_freq = 1.0  # Timer interval in seconds

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
