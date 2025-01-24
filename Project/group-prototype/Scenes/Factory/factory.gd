extends Node2D

var inventory = {
	"WOOD": 0,
}

func _ready() -> void:
	update_ui()

func _process(delta: float) -> void:
	pass

func add_to_inventory(item):
	if item.has("name"):
		var material_name = item["name"]
		var quantity = item.get("quantity", 1)
		
		if material_name in inventory:
			inventory[material_name] += quantity
		else:
			inventory[material_name] = quantity

		update_ui()

func update_ui():
	for material_name in inventory.keys():
		var quantity = inventory[material_name]
		
		match material_name:
			"WOOD":
				$UI/VBoxContainer/Wood_Panel/Label.text = str(quantity)
