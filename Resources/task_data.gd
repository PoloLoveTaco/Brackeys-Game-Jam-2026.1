extends Resource
class_name TaskData

@export var task_id: String = ""
@export var display_name: String = "Nom de la tâche"
@export var steps: Array[Dictionary] = []
# Step format : {"description": "Se faire un café", "is_done": false, "target_node": "CofeeMachine"}

signal task_completed

func complete_step(index: int):
	if index < steps.size():
		steps[index].is_done = true
		check_task_status()

func check_task_status():
	var all_done = true
	for step in steps:
		if not step.is_done:
			all_done = false
			break
	if all_done:
		task_completed.emit()
