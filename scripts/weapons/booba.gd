extends Node2D

var current_level:int = 1
var speed:float = 1
var projectile_size:float = 1
var area_size:float = 1

@export var distance_from_player:float = 128
@export var child_locations:Array[Vector2] = [
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0),
	Vector2(-1, 1), Vector2(1, -1), Vector2(1, 1), Vector2(-1, -1)
	]

var CharBody:CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():

	CharBody = $CharacterBody2D
	for child in CharBody.get_child_count():
		
		if child == 0:
			CharBody.get_child(child).set_visible(true)
			CharBody.get_child(child).set_process_mode(0)
		else:
			CharBody.get_child(child).set_visible(false)
			CharBody.get_child(child).set_process_mode(4)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func upgrade_weapon():
	match current_level:
		1:
			CharBody.get_child(1).set_visible(true)
			CharBody.get_child(1).set_process_mode(0)
		2:
			set_speed(speed+0.4)
		3:
			pass
		4:
			CharBody.get_child(2).set_visible(true)
			CharBody.get_child(2).set_process_mode(0)
			CharBody.get_child(3).set_visible(true)
			CharBody.get_child(3).set_process_mode(0)
		5:
			pass
		6:
			pass
		7:
			CharBody.get_child(4).set_visible(true)
			CharBody.get_child(4).set_process_mode(0)
			CharBody.get_child(5).set_visible(true)
			CharBody.get_child(5).set_process_mode(0)
			CharBody.get_child(6).set_visible(true)
			CharBody.get_child(6).set_process_mode(0)
			CharBody.get_child(7).set_visible(true)
			CharBody.get_child(7).set_process_mode(0)
	
	pass
	current_level+=1
	
	pass

func get_level():
	return current_level

func set_speed(new_speed:float):
	speed = new_speed
	$AnimationPlayer.set_speed_scale(speed)

func set_projectile_size(new_projectile_size:float):
	projectile_size = new_projectile_size
	for child in CharBody.get_child_count():
		CharBody.get_child(child).set_scale(Vector2(projectile_size, projectile_size))
	pass

func set_area_size(new_area_size:float):
	area_size = new_area_size
	for child in CharBody.get_child_count():
		child_locations[child].x, child_locations[child].y 
	sin(cos(1))
	pass

func _on_timer_timeout():
	upgrade_weapon() # Replace with function body.
	print("Level: ", current_level)
