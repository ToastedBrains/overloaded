extends Area2D

signal bomb_armed


func _on_body_entered(body):
	emit_signal("bomb_armed")
	queue_free()
