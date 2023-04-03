extends Node

var score
@export var mob_scene: PackedScene
@export var mob_timer = 1.0
@export var start_timer = 2.0
@export var score_timer = 1.0
# Called when the node enters the scene tree for the first time.
var start_position : Marker2D
var player_dom : CharacterBody2D
func _ready():
	$MobTimer.wait_time = mob_timer
	$StartTimer.wait_time = start_timer
	$ScoreTimer.wait_time = score_timer
	start_position = get_node("../start_position")
	player_dom = get_node("../Player_Dom")
	new_game()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MobPath.position = player_dom.position

func _on_player_dom_death():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	player_dom.start(start_position.position)
	$StartTimer.start()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	print("spawn")
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.set_player(player_dom)
	
	mob.position = mob_spawn_location.global_position
	
	add_child(mob)


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
