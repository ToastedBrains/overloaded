extends Area2D

var base_damage = 1.0
var speed = 500.0
var scope = 600.0
var travelled_distance = 0

	
func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > scope:
		queue_free()

func _on_body_entered(body): 
	if body.has_method("take_damage"):
		body.take_damage(base_damage + randi_range(0, 20))
		queue_free()
