extends Node2D

var inventory = {
	"WOOD": 0,
	"STONE": 0
}

var currency = 0

func _ready() -> void:
	currency = GameController.currency
	inventory = GameController.inventory
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
	$Camera2D/UI/VBoxContainer/Currency_Panel/Label.text = str(currency)
	
	for material_name in inventory.keys():
		var quantity = inventory[material_name]
		
		match material_name:
			"WOOD":
				$Camera2D/UI/VBoxContainer/Wood_Panel/Label.text = str(quantity)
			"STONE":
				$Camera2D/UI/VBoxContainer/Stone_Panel/Label.text = str(quantity)

func add_currency(amount = null):
	if amount:
		currency += amount
	else:
		currency += 1
	
	update_ui()

func sub_currency(amount = null):
	if amount:
		currency -= amount
	else:
		currency += 1
	
	update_ui()

func _on_play_button_pressed() -> void:
	GameController.currency = currency
	GameController.inventory = inventory
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
