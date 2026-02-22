extends TaskItem

@export var new_material: StandardMaterial3D

func interact():
	super()

	mesh.set_surface_override_material(1, new_material)

	TaskManager.on_step_finished(TaskManager.current_task.step_index)
	
	# Faire couler le café
