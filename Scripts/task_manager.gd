extends Node

var current_task: TaskData
var completed_tasks_count: int = 0

signal new_task_assigned(task: TaskData)
signal anomaly_triggered
signal task_ui_update

var tasks = [
	preload("res://Resources/Tasks/print_file.tres"),
	preload("res://Resources/Tasks/take_a_coffee.tres"),
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
	completed_tasks_count += 1
	task_index += 1
	current_task = tasks[task_index]
	current_task.task_completed.connect(on_task_finished)
	task_ui_update.emit()
