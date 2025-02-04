extends Camera2D

# Zoom variables
@export var zoom_speed: float = 0.3
@export var min_zoom: Vector2 = Vector2(1, 1)
@export var max_zoom: Vector2 = Vector2(5, 5)

# Drag variables
var dragging: bool = false
var drag_start_position: Vector2 = Vector2.ZERO

# Camera constraints
@export var camera_limit_left: float = 560
@export var camera_limit_right: float = 1560
@export var camera_limit_top: float = 0
@export var camera_limit_bottom: float = 1000

func _physics_process(_delta):
	_handle_zoom()
	_handle_drag()

func _handle_zoom():
	if Input.is_action_just_released("zoom_in"):
		_zoom_in()
	if Input.is_action_just_released("zoom_out"):
		_zoom_out()

func _zoom_in():
	if self.zoom.x < max_zoom.x:
		self.zoom.x += zoom_speed
		self.zoom.y += zoom_speed
		self.zoom.x = min(self.zoom.x, max_zoom.x)
		self.zoom.y = min(self.zoom.y, max_zoom.y)

func _zoom_out():
	if self.zoom.x > min_zoom.x:
		self.zoom.x -= zoom_speed
		self.zoom.y -= zoom_speed
		self.zoom.x = max(self.zoom.x, min_zoom.x)
		self.zoom.y = max(self.zoom.y, min_zoom.y)

func _handle_drag():
	if Input.is_action_just_pressed("middle_mouse"):
		dragging = true
		drag_start_position = get_global_mouse_position()
	
	if Input.is_action_just_released("middle_mouse"):
		dragging = false
	
	if dragging:
		var drag_vector = drag_start_position - get_global_mouse_position()
		position += drag_vector
		drag_start_position = get_global_mouse_position()
		_apply_camera_limits()

func _apply_camera_limits():
	position.x = clamp(position.x, camera_limit_left, camera_limit_right)
	position.y = clamp(position.y, camera_limit_top, camera_limit_bottom)
