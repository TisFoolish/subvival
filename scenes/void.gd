extends Node

var score
@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MobPath.position = $Player_Dom.position

func _on_player_dom_death():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player_Dom.start($Startposition.position)
	$StartTimer.start()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.set_player($Player_Dom)
	
	mob.position = mob_spawn_location.global_position
	
	add_child(mob)


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
