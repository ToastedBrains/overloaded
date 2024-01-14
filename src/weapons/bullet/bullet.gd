extends Area2D

const SPEED = 1200.0
const SCOPE = 3000
const IMPACT = 20.0
var distance = 0

func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * SPEED * delta
	distance += SPEED * delta
	if distance > SCOPE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		#queue_free()
		body.take_damage()
	if body.has_method("get_pushed"):
		body.get_pushed(Vector2.from_angle(global_rotation), IMPACT)
