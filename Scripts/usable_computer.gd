extends TaskItem

@onready var pc_camera: Camera3D = $Camera3D
@onready var screen: MeshInstance3D = $Screen
@onready var printer_icon_area: Area3D = $Screen/PrintIcon/Area3D

@export var transition_time: float = 0.8 # Durée du voyage de la caméra

signal file_is_printed

func _ready() -> void:
	screen.visible = false

func interact():
	super()
	var player = get_tree().get_first_node_in_group("player")
	if player and pc_camera:
		var player_cam = player.get_node("Head/Camera3D")
		var crosshair = player.get_node("CanvasLayer/Crosshair")
		
		player.set_frozen(true)
		crosshair.visible = false
		self.set_highlight(false)
		
		# Lancement de la transition vers le PC
		transition_camera(player_cam, pc_camera, true)

func exit_pc():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var player_cam = player.get_node("Head/Camera3D")
		# Lancement de la transition vers le Joueur
		transition_camera(pc_camera, player_cam, false)

func transition_camera(from_cam: Camera3D, to_cam: Camera3D, entering_pc: bool):
	# 1. Créer une caméra de transition temporaire
	var temp_cam = Camera3D.new()
	add_child(temp_cam)
	
	# 2. Copier les paramètres de la caméra de départ
	temp_cam.global_transform = from_cam.global_transform
	temp_cam.fov = from_cam.fov
	temp_cam.make_current()
	
	# 3. Créer le Tween pour déplacer la caméra
	var tween = create_tween()
	# On gère le mouvement et la rotation en même temps
	tween.tween_property(temp_cam, "global_transform", to_cam.global_transform, transition_time)\
		.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	
	# 4. Une fois arrivé
	await tween.finished
	
	to_cam.make_current() # On active la vraie caméra de destination
	temp_cam.queue_free() # On détruit la caméra temporaire
	
	if entering_pc:
		screen.visible = true
	else:
		var player = get_tree().get_first_node_in_group("player")
		player.set_frozen(false)
		player.get_node("CanvasLayer/Crosshair").visible = true
		screen.visible = false

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		exit_pc()
		file_is_printed.emit()
		TaskManager.on_step_finished(TaskManager.current_task.step_index)
