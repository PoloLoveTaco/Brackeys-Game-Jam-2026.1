extends Control

@onready var name_label: Label = $Panel/VBoxContainer/Name
@onready var description_label: Label = $Panel/VBoxContainer/Description

func _ready() -> void:
	name_label.text = TaskManager.current_task.display_name
	
	description_label.text = ""
	
	for step in TaskManager.current_task.steps:
		var step_string = "[  ] " + step.description + "\n"
		description_label.text += step_string
