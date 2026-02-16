extends Node
class_name TaskItem

@export var id: String
var outline_material = preload("res://Materials/highlight_material.tres")

@onready var mesh = $CoffeeCup

func set_highlight(enabled: bool):
	if enabled:
		mesh.set_instance_shader_parameter("highlight_active", 1.0)
		mesh.material_overlay = outline_material
	else:
		mesh.material_overlay = null

func interact():
	print("Interact with a task item: " + id)
