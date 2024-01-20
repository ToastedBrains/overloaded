extends Area2D

signal artefact_collected

func _on_body_entered(body):
	emit_signal("artefact_collected")
	queue_free()
