extends Node

signal new_ennemi



const ENNEMI = preload("res://src/ennemies/ennemy/ennemy.tscn")

var ennemies = 0
var ennemies_down = 0



func _ready():
	%Music.play()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
		
func pause_game():
	if Vars.game_state == Vars.State.PAUSED:
		%Skills.hide_skills()
		Engine.time_scale = 1
		Vars.game_state = Vars.State.PLAYING
	else:
		%Skills.show_skills()
		Engine.time_scale = 0.001
		Vars.game_state = Vars.State.PAUSED


func spawn():
	var new_ennemi = ENNEMI.instantiate()
	new_ennemi.target = %Player
	%PathFollow2D.progress_ratio = randf()
	new_ennemi.global_position = %PathFollow2D.global_position
	new_ennemi.ennemy_down.connect(self._on_ennemy_down)
	call_deferred("add_child", new_ennemi)
	emit_signal("new_ennemi")


func spawn_more():
	%SpawnTimer.wait_time /= 1.1

func _on_spawn_timer_timeout():
	spawn()


func _on_ennemy_down():
	ennemies_down += 1
	ennemies -= 1
	%HUD.update_debug(ennemies, ennemies_down)


func _on_new_ennemi():
	ennemies += 1
	%HUD.update_debug(ennemies, ennemies_down)


func _on_player_player_health_exhausted():
	#Debug.print("Player health = 0")
	pass


func _on_skills_skills_modified():
	#Debug.print("Skills update")
	%Player.update_skills(Vars.skills)
	%HUD.hide_skill_message()


func _on_player_skill_point_earned():
	%Skills.update_points()
	%HUD.show_skill_message()
	spawn_more()

func _on_player_exp_gained():
	%HUD.update_xp()
