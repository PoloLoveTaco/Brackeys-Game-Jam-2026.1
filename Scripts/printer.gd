extends TaskItem

@onready var file := $File

func set_highlight(enabled: bool):
	if enabled:
		mesh.set_instance_shader_parameter("highlight_active", 1.0)
		mesh.material_overlay = outline_material
		
		file.set_instance_shader_parameter("highlight_active", 1.0)
		file.material_overlay = outline_material
	else:
		mesh.material_overlay = null
		file.material_overlay = null

func _ready() -> void:
	file.visible = false
	get_tree().get_first_node_in_group("my_pc").file_is_printed.connect(print_file)
	
func print_file():
	file.visible = true

func interact():
	super()
	file.visible = false
	TaskManager.on_step_finished(TaskManager.current_task.step_index)
