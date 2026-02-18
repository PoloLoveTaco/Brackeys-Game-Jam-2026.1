extends Control

@onready var name_label: Label = $Panel/VBoxContainer/Name
@onready var description_label: Label = $Panel/VBoxContainer/Description

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
