extends Node2D

@onready var cloneButton1 = $clonebox/HBoxContainer/clone1button
@onready var cloneButton2 = $clonebox/HBoxContainer/clone2button
@onready var cloneButton3 = $clonebox/HBoxContainer/clone3button
@onready var cloneButton4 = $clonebox/HBoxContainer/clone4button
@onready var cloneButton5 = $clonebox/HBoxContainer/clone5button

@onready var cloneBar1 = $clonebox/clone1Bar
@onready var cloneBar2 = $clonebox/clone2Bar
@onready var cloneBar3 = $clonebox/clone3Bar
@onready var cloneBar4 = $clonebox/clone4Bar
@onready var cloneBar5 = $clonebox/clone5Bar


func regenBar(bar, speed):
	bar.value += speed
	if bar.value == 100:
		bar.hide()

func resetBar(bar, ver):
	if bar.value == 100:
		bar.value = 0
		PlayerInfo.playerVer = ver
		bar.show()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	regenBar(cloneBar1, 1)
	regenBar(cloneBar2, .5)
	regenBar(cloneBar3, .25)
	regenBar(cloneBar4, .125)
	regenBar(cloneBar5, .0625)


func _on_clone_1_button_pressed() -> void:
	resetBar(cloneBar1,1)
	


func _on_clone_2_button_pressed() -> void:
	resetBar(cloneBar2,2)
	


func _on_clone_3_button_pressed() -> void:
	resetBar(cloneBar3,3)
	


func _on_clone_4_button_pressed() -> void:
	resetBar(cloneBar4,4)


func _on_clone_5_button_pressed() -> void:
	resetBar(cloneBar5,5)
