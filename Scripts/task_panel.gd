extends Node3D

@onready var name_label: Label3D = $Name
@onready var description_label: Label3D = $Description

func _ready() -> void:
	TaskManager.task_ui_update.connect(update_task)
	update_task()

func update_task():
	name_label.text = TaskManager.current_task.display_name
	
	description_label.text = ""
	
	for step in TaskManager.current_task.steps:
		var check = "[  ] "
		if step.is_done:
			check = "[X] "
			
		var step_string = check + step.description + "\n"
		description_label.text += step_string
