# meta-name: Base Subvival weapon script
# meta-description: Presetup script for weapons in Subvival
# meta-default: false
# meta-space-indent: 4
extends Node2D

var current_level:int = 1
var speed:float = 1
var projectile_size:float = 1
var area_size:float = 1

var CharBody:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func upgrade_weapon():
	match current_level:
		1:
			pass
	pass

func evolve_weapon():
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
	pass
