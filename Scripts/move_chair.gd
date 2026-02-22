extends Anomaly

@onready var np: Node3D = $"../NewChairPos"

func play():
	super()
	
	global_position = np.global_position
