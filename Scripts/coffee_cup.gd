extends TaskItem


func interact():
	super()
	queue_free()
	TaskManager.on_step_finished(TaskManager.current_task.step_index)
