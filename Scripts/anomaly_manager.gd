extends Node

var ano_ids = [
	"return_pc",
	"hide_carpet",
	"move_chair",
	"microwave_anomaly",
	"hide_painting_anomaly"
]

var index = 0

func _ready() -> void:
	TaskManager.anomaly_triggered.connect(play_anomaly)
	
func play_anomaly():
	print("Anomaly Triggered")
	if index >= ano_ids.size():
		return

	get_tree().get_first_node_in_group(ano_ids[index]).play()
	
	index += 1
