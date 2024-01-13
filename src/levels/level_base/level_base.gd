extends Node

const ENNEMI = preload("res://src/ennemies/ennemy/ennemy.tscn")

func spawn():
	var new_ennemi = ENNEMI.instantiate()
	new_ennemi.target = %Player
	%PathFollow2D.progress_ratio = randf()
	new_ennemi.global_position = %PathFollow2D.global_position
	add_child(new_ennemi)


func _on_spawn_timer_timeout():
	spawn()
