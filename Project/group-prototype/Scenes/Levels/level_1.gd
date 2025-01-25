extends Node2D

@onready var ENEMY_SPAWN_POINT = $EnemySpawnPoint.position
@onready var ENEMY_NODE = $Enemies
@export var ENEMY_RESOURCE: Resource



func _on_spawn_timer_timeout() -> void:
	var enemy = ENEMY_RESOURCE.instantiate()
	enemy.global_position = ENEMY_SPAWN_POINT
	enemy.direction = Vector2(1,0)
	ENEMY_NODE.add_child(enemy)
