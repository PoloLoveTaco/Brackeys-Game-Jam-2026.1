extends Node

var current_task: TaskData
var completed_tasks_count: int = 0

signal new_task_assigned(task: TaskData)
signal anomaly_triggered

func _init() -> void:
	current_task = preload("res://Resources/Tasks/print_file.tres")

func assign_task(task_res: TaskData):
	current_task = task_res
	new_task_assigned.emit(current_task)
	
func on_step_finished(step_index: int):
	current_task.complete_step(step_index)
	anomaly_triggered.emit()
