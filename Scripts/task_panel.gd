extends Node3D

@onready var name_label: Label3D = $Name
@onready var description_label: Label3D = $Description

var done: bool = false

func _ready() -> void:
	TaskManager.task_ui_update.connect(update_task)
	TaskManager.all_tasks_completed.connect(tasks_finished)
	update_task()

func update_task():
	if done: return
	name_label.text = TaskManager.current_task.display_name
	
	description_label.text = ""
	
	for step in TaskManager.current_task.steps:
		var check = "[  ] "
		if step.is_done:
			check = "[X] "
			
		var step_string = check + step.description + "\n"
		description_label.text += step_string
		
func tasks_finished():
	done = true
	name_label.text = "The game is finished you are free to find the chair !"
	description_label.text = "[  ] Give a feedback in the itch.io page"
