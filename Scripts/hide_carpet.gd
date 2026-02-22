extends Anomaly

@onready var hide_carpet: Node3D = $"."

func _ready() -> void:
	hide_carpet.visible = false

func play():
	hide_carpet.visible = true
