class_name PositionLerp
extends CameraControllerBase

@export var follow_speed: float = 200
@export var catchup_speed: float = 6
@export var leash_distance: float = 14

var _speed: float = 2

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
		
		if cplane.distance_to(tplane) > leash_distance:
			_speed = target_spd
		else:	
			var speed_map = func(dist: float):
				var new_speed = (dist / leash_distance)**2 * target_spd
				return clampf(new_speed, catchup_speed, target_spd)
			_speed = speed_map.call(xz_dist)
		
		global_position += _speed * target_dir * delta
	else:
		global_position.x = tpos.x
		global_position.z = tpos.z
		
	
	
