extends Node2D

@onready var ENEMY_SPAWN_POINT = $EnemySpawnPoint.position
@onready var ENEMY_NODE = $Enemies
@onready var SPAWN_TIMER = $EnemySpawnPoint/SpawnTimer
@export var ENEMY_RESOURCE: Resource

var enemy_array = []
var round_complete : bool = false
var current_round : int = 0
var next_round : int = 1

var wood : int
var stone : int

func _ready() -> void:
	import_resources()
	update_resource_labels()

# start level
func _on_play_button_pressed() -> void:
	$Control/PlayButton.disabled = true
	start_level()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func create_enemy(level: int):
	var enemy = ENEMY_RESOURCE.instantiate()
	enemy.global_position = ENEMY_SPAWN_POINT
	enemy.direction = Vector2(1,0)
	enemy.level = level
	return enemy

func spawn_enemy():
	if enemy_array.is_empty():
		SPAWN_TIMER.stop()
		start_level()
		return
	
	ENEMY_NODE.add_child(enemy_array[0])
	enemy_array.remove_at(0)

func start_level():
	match next_round:
		1:
			round_one()
		2:
			round_two()
		3:
			round_three()
		4:
			round_four()
		5:
			round_five()

func update_currency_label():
	$Control/CurrencyLabel.text = "Currency: " + str(GameController.currency)

func import_resources():
	wood = GameController.inventory["WOOD"]
	stone = GameController.inventory["STONE"]

func update_resource_labels():
	$Control/WoodLabel.text = "Wood: " + str(wood)
	$Control/StoneLabel.text = "Stone: " + str(stone)



# LEVEL ROUNDS

# ROUND 1: 20 REDS
func round_one():
	current_round = 1
	next_round = 2
	for i in 20:
		enemy_array.append(create_enemy(1))
	
	SPAWN_TIMER.start()

# ROUND 2: 10 REDS, 10 BLUES
func round_two():
	current_round = 2
	next_round = 3
	for i in 10:
		enemy_array.append(create_enemy(1))
		enemy_array.append(create_enemy(2))
	
	SPAWN_TIMER.start()

# ROUND 3: 15 REDS, 15 BLUES, 5 GREENS
func round_three():
	current_round = 3
	next_round = 4
	for i in 5:
		enemy_array.append(create_enemy(3))
		for j in 3:
			enemy_array.append(create_enemy(1))
			enemy_array.append(create_enemy(2))
	
	SPAWN_TIMER.start()

# ROUND 4: 15 BLUES, 5 GREENS, 2 PURPLES
func round_four():
	current_round = 4
	next_round = 5
	enemy_array.append(create_enemy(4))
	for i in 5:
		enemy_array.append(create_enemy(3))
		for j in 3:
			enemy_array.append(create_enemy(2))
	enemy_array.append(create_enemy(4))
	
	SPAWN_TIMER.start()

# ROUND 5: 10 GREENS, 5 PURPLES, 2 ORANGES
func round_five():
	current_round = 5
	enemy_array.append(create_enemy(5))
	for i in 5:
		enemy_array.append(create_enemy(4))
		for j in 2:
			enemy_array.append(create_enemy(3))
	enemy_array.append(create_enemy(5))
	
	SPAWN_TIMER.start()


func _on_factory_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Factory/factory.tscn")
