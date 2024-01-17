extends Area2D

signal collected
var velocity = Vector2.ZERO
var target : Node2D

func _process(delta):
	if target:
		velocity = target.global_position - global_position
		global_position += velocity * 10.0 * delta
	
func picked_up(picker):
	target = picker
	Debug.print("DNA picked up")
	emit_signal("collected")
	#queue_free()
