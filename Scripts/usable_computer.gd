extends TaskItem

@onready var pc_camera: Camera3D = $Camera3D
@onready var screen: MeshInstance3D = $Screen
@onready var printer_icon_area: Area3D = $Screen/PrintIcon/Area3D

signal file_is_printed

func _ready() -> void:
	screen.visible = false

func interact():
	super()
	var player = get_tree().get_first_node_in_group("player")
	if player and pc_camera:
		var crosshair = player.get_node("CanvasLayer/Crosshair")
		player.set_frozen(true)
		crosshair.visible = false
		screen.visible = true
		self.set_highlight(false)
		pc_camera.make_current()


func exit_pc():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.set_frozen(false)
		player.get_node("CanvasLayer/Crosshair").visible = true
		player.get_node("Head/Camera3D").make_current()
		screen.visible = false

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		exit_pc()
		file_is_printed.emit()
		TaskManager.on_step_finished(TaskManager.current_task.step_index)
