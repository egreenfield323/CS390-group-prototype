extends Node2D

var inventory = {
	"WOOD": 0,
	"STONE": 0
}

var currency = 0

func _ready() -> void:
	update_ui()

func _process(delta: float) -> void:
	pass

func add_to_inventory(item):
	if item["name"]:
		var material_name = item["name"]
		var quantity = item.get("quantity", 1)
		
		if material_name in inventory:
			inventory[material_name] += quantity
		else:
			inventory[material_name] = quantity

		update_ui()

func update_ui():
	$UI/VBoxContainer/Currency_Panel/Label.text = str(currency)
	
	for material_name in inventory.keys():
		var quantity = inventory[material_name]
		
		match material_name:
			"WOOD":
				$UI/VBoxContainer/Wood_Panel/Label.text = str(quantity)
			"STONE":
				$UI/VBoxContainer/Stone_Panel/Label.text = str(quantity)

func add_currency(amount = null):
	if amount:
		currency += amount
	else:
		currency += 1
