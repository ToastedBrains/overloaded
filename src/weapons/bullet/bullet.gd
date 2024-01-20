extends Area2D

var travelled_distance = 0
	
func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * Vars.speed * delta
	travelled_distance += Vars.speed * delta
	if travelled_distance > Vars.scope:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(Vars.base_damage + randi_range(0, Vars.max_random_damage))
		if not Vars.piercing:
			queue_free()
		elif randi_range(0, 2) == 0:
			queue_free()

			
	if body.has_method("get_pushed"):
		body.get_pushed(Vector2.from_angle(global_rotation), Vars.impact)
	
