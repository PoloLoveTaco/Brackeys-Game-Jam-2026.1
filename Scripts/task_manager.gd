extends Node

var current_task: TaskData
var completed_tasks_count: int = 0

signal new_task_assigned(task: TaskData)
signal anomaly_triggered
signal task_ui_update

signal all_tasks_completed

var tasks = [
	preload("res://Resources/Tasks/print_file.tres"),
	preload("res://Resources/Tasks/take_a_coffee.tres"),
	preload("res://Resources/Tasks/clean_whiteboard.tres"),
]
var task_index = 0

func _init() -> void:
	current_task = tasks[task_index]
	current_task.task_completed.connect(on_task_finished)

func assign_task(task_res: TaskData):
	current_task = task_res
	task_ui_update.emit()
	new_task_assigned.emit(current_task)
	
func on_step_finished(step_index: int):
	current_task.complete_step(step_index)
	task_ui_update.emit()
	anomaly_triggered.emit()
	
func on_task_finished():
	task_index += 1
	if task_index >= tasks.size():
		all_tasks_completed.emit()
		return
	completed_tasks_count += 1
	current_task = tasks[task_index]
	current_task.task_completed.connect(on_task_finished)
	task_ui_update.emit()
