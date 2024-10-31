class_name PositionLerp
extends CameraControllerBase

@export var follow_speed: float = 30
@export var catchup_speed: float = 16
@export var leash_distance: float = 8
@export var catchup_slowdown_leash: float = 2

var _speed: float = 2


func _ready() -> void:
	super()
	position = target.position


func _process(delta) -> void:
	if not current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	var tplane = Vector2(tpos.x, tpos.z)
	var cplane = Vector2(cpos.x, cpos.z)
	
	if not cplane.distance_to(tplane) < 0.1:
		
		var plane_dist_vector = Vector2(tpos.x - cpos.x, tpos.z - cpos.z)
		var xz_dist = plane_dist_vector.length()
		var plane_target_dir = plane_dist_vector.normalized()
		var target_dir = Vector3(plane_target_dir.x, 0 , plane_target_dir.y)
		var target_spd = target.velocity.length()
		var dist_ratio = clampf(xz_dist / leash_distance, 0, 1)
		
		if target_spd > 0:
			if cplane.distance_to(tplane) > leash_distance:
				_speed = target_spd
			else:	
				_speed = lerp(follow_speed, target_spd, dist_ratio)
		else:
			var catchup_dist_ratio = clampf(xz_dist / catchup_slowdown_leash, 0, 1)
			_speed = lerp(catchup_speed, 0.0, 1.0 - catchup_dist_ratio)
		global_position += _speed * target_dir * delta
	else:
		global_position.x = tpos.x
		global_position.z = tpos.z
		
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
