class_name LeadingLerp
extends CameraControllerBase

@export var catchup_delay_duration: float = 0.12
@export var catchup_speed: float = 16
@export var leash_distance: float = 8

var _catchup: bool = false
var _speed: float = 2
var _timer: Timer

func _ready() -> void:
	super()
	_timer = Timer.new()
	_timer.timeout.connect(_on_timer_end)
	_timer.autostart = false
	_timer.one_shot = true
	add_child(_timer)
	

func _process(delta) -> void:
	if not current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	var plane_dist_vector = Vector2(tpos.x - cpos.x, tpos.z - cpos.z)
	var cam_target_dir = Vector3(plane_dist_vector.x, 0, plane_dist_vector.y)
	
	var target_spd = target.velocity.length()

	if not is_zero_approx(target_spd):
		_timer.stop()
		_catchup = false
		_speed = target_spd
		var target_dir = target.velocity.normalized()
		var go_to_point = tpos + target_dir * leash_distance
		go_to_point.y = global_position.y
	
		global_position += _speed * target_dir * delta
		global_position = lerp(global_position, go_to_point, 1 - 0.05**delta)
	elif _catchup:
		global_position += (catchup_speed) * cam_target_dir * delta
	elif _timer.is_stopped() and not _catchup:
		_timer.start(catchup_delay_duration)
		
	super(delta)
	

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()


func _on_timer_end() -> void:
	_catchup = true
