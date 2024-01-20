extends Area2D

signal player_teleported

func _on_body_entered(body):
	emit_signal("player_teleported")
	queue_free()
