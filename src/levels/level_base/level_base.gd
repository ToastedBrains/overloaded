extends Node

signal new_ennemi

const ENNEMI = preload("res://src/ennemies/ennemy/ennemy.tscn")
var ennemies = 0
var ennemies_down = 0

func spawn():
	var new_ennemi = ENNEMI.instantiate()
	new_ennemi.target = %Player
	%PathFollow2D.progress_ratio = randf()
	new_ennemi.global_position = %PathFollow2D.global_position
	new_ennemi.ennemy_down.connect(self._on_ennemy_down)
	call_deferred("add_child", new_ennemi)
	emit_signal("new_ennemi")

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
	Debug.print("Player health = 0")
