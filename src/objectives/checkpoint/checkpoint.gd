extends Area2D

signal checkpoint_reached

func _on_body_entered(body):
	emit_signal("checkpoint_reached")
	queue_free()
