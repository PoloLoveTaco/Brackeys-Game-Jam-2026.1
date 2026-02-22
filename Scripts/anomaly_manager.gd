extends Node

var ano_ids = [
	"return_pc"
]

func _ready() -> void:
	TaskManager.anomaly_triggered.connect(play_anomaly)
	
func play_anomaly():
	print("Anomaly Triggered")

	get_tree().get_first_node_in_group(ano_ids[0]).play()
