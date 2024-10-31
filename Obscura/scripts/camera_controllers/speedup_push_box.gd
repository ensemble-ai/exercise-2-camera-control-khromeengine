class_name SpeedupPushBox
extends CameraControllerBase


@export var push_ratio: float = 0.2
@export var pushbox_top_left: Vector2 = Vector2.ZERO
@export var pushbox_bottom_right: Vector2 = Vector2.ZERO
@export var speedup_zone_top_left: Vector2 = Vector2.ZERO
@export var speedup_zone_bottom_right: Vector2 = Vector2.ZERO


@onready var tpos = target.global_position
@onready var tspd = target.velocity
var cpos = global_position

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	_recompute()
	
	# Speedup Zone Checks
	#left
	var dist_to_push_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_top_left.x)
	var dist_to_speed_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x - speedup_zone_top_left.x)

	
	if dist_to_speed_left < 0 and target.velocity.x < 0:
		var dist_ratio = abs(dist_to_speed_left / (pushbox_top_left.x - speedup_zone_top_left.x))
		var left_speed = lerp(push_ratio * tspd.x, 0.5 * tspd.x, dist_ratio)
		global_position.x += left_speed * delta
		
	#right
	var dist_to_push_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x)
	var dist_to_speed_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.x)
	
	if dist_to_speed_right > 0 and target.velocity.x > 0:
		var dist_ratio = abs(dist_to_speed_right / (pushbox_bottom_right.x - speedup_zone_bottom_right.x))
		var right_speed = lerp(push_ratio * tspd.x, 0.5 * tspd.x, dist_ratio)
		global_position.x += right_speed * delta
	
	#top
	var dist_to_push_top = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y)
	var dist_to_speed_top = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - speedup_zone_top_left.y)
	
	if dist_to_speed_top < 0 and target.velocity.z < 0:
		var dist_ratio = abs(dist_to_speed_top / (pushbox_top_left.y - speedup_zone_top_left.y))
		var up_speed = lerp(push_ratio * tspd.z, 0.5 * tspd.z, dist_ratio)
		global_position.z += up_speed * delta
	
	#bottom
	var dist_to_push_bottom = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_bottom_right.y)
	var dist_to_speed_bottom = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_zone_bottom_right.y)
	
	if dist_to_speed_bottom > 0 and target.velocity.z > 0:
		var dist_ratio = abs(dist_to_speed_bottom / (pushbox_bottom_right.y - speedup_zone_bottom_right.y))
		var down_speed = lerp(push_ratio * tspd.z, 0.5 * tspd.z, dist_ratio)
		global_position.z += down_speed * delta
		
		
	# Need to refresh after changing all spds to properly push back.
	_recompute()
	
	dist_to_push_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_top_left.x)
	dist_to_push_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x)
	dist_to_push_top = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y)
	dist_to_push_bottom = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_bottom_right.y)
	
	# Boundary Checks
	
	if dist_to_push_left < 0:
		global_position.x += dist_to_push_left
	elif dist_to_push_right > 0:
		global_position.x += dist_to_push_right
		
	if dist_to_push_top < 0:
		global_position.z += dist_to_push_top
	elif dist_to_push_bottom > 0:
		global_position.z += dist_to_push_bottom
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -pushbox_top_left.x
	var right:float = pushbox_bottom_right.x
	var top:float = -pushbox_top_left.y
	var bottom:float = pushbox_bottom_right.y
	
	var inner_left:float = -speedup_zone_top_left.x
	var inner_right:float = speedup_zone_bottom_right.x
	var inner_top:float = -speedup_zone_top_left.y
	var inner_bottom:float = speedup_zone_bottom_right.y
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_top))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_top))
	immediate_mesh.surface_end()


	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()


func _recompute() -> void:
	tpos = target.global_position
	cpos = global_position
	tspd = target.velocity
