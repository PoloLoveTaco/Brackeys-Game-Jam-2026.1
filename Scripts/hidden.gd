extends Anomaly

func _ready() -> void:
	visible = false

func play():
	super()
	visible = true
	$"../Visible".queue_free()
