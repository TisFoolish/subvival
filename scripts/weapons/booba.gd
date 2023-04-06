extends Node2D

var current_level:int = 1
var speed:float = .5
var projectile_size:float = 1
var area_size:float = 1
var diagonal_distance:float = sqrt(2)/2
var damage_scale:float = 1
var base_damage:float = 5

@export var distance_from_player:float = 100
@export var child_locations:Array[Vector2] = [
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0),
	Vector2(-1, 1), Vector2(1, -1), Vector2(1, 1), Vector2(-1, -1)
	]


signal evolved

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $MilkLasers.get_child_count():
		$MilkLasers.get_child(child).set_visible(false)
		$MilkLasers.get_child(child).set_process_mode(PROCESS_MODE_DISABLED)
	for child in $BaseWeapon.get_child_count():
		if child == 0:
			$BaseWeapon.get_child(child).set_visible(true)
			$BaseWeapon.get_child(child).set_process_mode(PROCESS_MODE_INHERIT)
		else:
			$BaseWeapon.get_child(child).set_visible(false)
			$BaseWeapon.get_child(child).set_process_mode(PROCESS_MODE_DISABLED)
		_set_area_size(area_size)
		_set_projectile_size(projectile_size)
		_set_speed(speed)
		_set_damage(damage_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func upgrade_weapon():
	match current_level:
		1:
			$BaseWeapon.get_child(1).set_visible(true)
			$BaseWeapon.get_child(1).set_process_mode(PROCESS_MODE_INHERIT)
		2:
			_set_speed(speed+0.4)
			_set_projectile_size(projectile_size+0.25)
		3:
			_set_area_size(area_size+0.25)
			_set_damage(damage_scale+0.2)
		4:
			$BaseWeapon.get_child(2).set_visible(true)
			$BaseWeapon.get_child(2).set_process_mode(PROCESS_MODE_INHERIT)
			$BaseWeapon.get_child(3).set_visible(true)
			$BaseWeapon.get_child(3).set_process_mode(PROCESS_MODE_INHERIT)
		5:
			_set_speed(speed+0.25)
			_set_damage(damage_scale+0.2)
		6:
			_set_speed(speed+0.25)
			_set_area_size(area_size+0.25)
			_set_projectile_size(projectile_size+0.25)
		7:
			$BaseWeapon.get_child(4).set_visible(true)
			$BaseWeapon.get_child(4).set_process_mode(PROCESS_MODE_INHERIT)
			$BaseWeapon.get_child(5).set_visible(true)
			$BaseWeapon.get_child(5).set_process_mode(PROCESS_MODE_INHERIT)
			$BaseWeapon.get_child(6).set_visible(true)
			$BaseWeapon.get_child(6).set_process_mode(PROCESS_MODE_INHERIT)
			$BaseWeapon.get_child(7).set_visible(true)
			$BaseWeapon.get_child(7).set_process_mode(PROCESS_MODE_INHERIT)
	
	current_level+=1


func get_level():
	return current_level

func _set_speed(new_speed:float):
	speed = new_speed
	$AnimationPlayer.set_speed_scale(speed)
#	for child in $BaseWeapon.get_child_count():
#		$BaseWeapon.get_child(child).find_child("AnimationPlayer").set_speed_scale(speed)
		
#		$BaseWeapon.get_child(child).find_child("AnimationPlayer").stop()

func _set_projectile_size(new_projectile_size:float):
	projectile_size = new_projectile_size
	for child in $BaseWeapon.get_child_count():
		$BaseWeapon.get_child(child).set_scale(Vector2(
			projectile_size, projectile_size))
	for child in $MilkLasers.get_child_count():
		$MilkLasers.get_child(child).set_scale(Vector2(
			projectile_size, projectile_size))

func _set_area_size(new_area_size:float):
	area_size = new_area_size
	for child in $BaseWeapon.get_child_count():
		var temp:Vector2 = child_locations[child]
		if(temp.x != 0 && temp.y != 0):
			$BaseWeapon.get_child(child).set_position(Vector2(
				temp.x*diagonal_distance*distance_from_player*area_size,
				temp.y*diagonal_distance*distance_from_player*area_size))
		else:
			$BaseWeapon.get_child(child).set_position(Vector2(
				temp.x*distance_from_player*area_size,
				temp.y*distance_from_player*area_size))
	for child in $MilkLasers.get_child_count():
		var temp:Vector2 = child_locations[child]
		if(temp.x != 0 && temp.y != 0):
			$MilkLasers.get_child(child).set_position(Vector2(
				temp.x*diagonal_distance*distance_from_player*area_size,
				temp.y*diagonal_distance*distance_from_player*area_size))
		else:
			$MilkLasers.get_child(child).set_position(Vector2(
				temp.x*distance_from_player*area_size,
				temp.y*distance_from_player*area_size))

	pass

func _set_damage(new_damage:float):
	damage_scale = new_damage

func evolve_weapon():
	for child in $BaseWeapon.get_child_count():
		$BaseWeapon.get_child(child).find_child("AnimatedSprite2D").play("evolved")
	for child in $MilkLasers.get_child_count():
		$MilkLasers.get_child(child).set_visible(true)
		$MilkLasers.get_child(child).set_process_mode(PROCESS_MODE_INHERIT)
	emit_signal("evolved")

func get_damage():
	return base_damage * damage_scale
	pass

func _on_timer_timeout():
	if(current_level < 8):
		upgrade_weapon() # Replace with function body.
		print("Level: ", current_level)
	else: 
		evolve_weapon()
		$TempUpTimer.stop()
		print("Evolved")

