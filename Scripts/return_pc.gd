extends Anomaly

func play():
	super()
	global_position.y += 0.2
	global_position.z -= 0.3
	global_rotation_degrees = Vector3(1.2, 90.0, 90.0)
