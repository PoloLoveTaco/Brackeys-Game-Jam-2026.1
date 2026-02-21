extends TaskItem

@onready var pc_camera: Camera3D = $Camera3D

@onready var screen: MeshInstance3D = $Screen

func _ready() -> void:
	screen.visible = false

func interact():
	super()
	
	var player = get_tree().get_first_node_in_group("player")

	if player and pc_camera:
		
		var crosshair = player.get_node("CanvasLayer/Crosshair")
		
		player.set_frozen(true)
		crosshair.visible = false
		screen.visible = true
		self.set_highlight(false)
		pc_camera.make_current()
		
		
		# cliquer sur l'icon imprimente et sa quitte l'ordinateur
