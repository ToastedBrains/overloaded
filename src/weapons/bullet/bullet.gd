extends Area2D

var base_damage = 10.0
var max_random_damage = 4
var speed = 1200.0
var scope = 3000
var impact = 20.0
var travelled_distance = 0

func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > scope:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(base_damage + randi_range(0, max_random_damage))
	if body.has_method("get_pushed"):
		body.get_pushed(Vector2.from_angle(global_rotation), impact)
