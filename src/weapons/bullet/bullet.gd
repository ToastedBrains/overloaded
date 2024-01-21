extends Area2D


@onready var level = get_tree().get_nodes_in_group("level").front()
var travelled_distance = 0
const SHRAPNEL = preload("res://src/weapons/shrapnel/shrapnel.tscn")
	
func _process(delta):
	var direction = Vector2.from_angle(global_rotation)
	position += direction * Vars.speed * delta
	travelled_distance += Vars.speed * delta
	if travelled_distance > Vars.scope:
		queue_free()


func explode():
	Debug.print("EXPLODE!!!")
	for angle in 24:
		var new_shrapnel = SHRAPNEL.instantiate()
		new_shrapnel.global_position = global_position
		new_shrapnel.global_rotation_degrees += angle * 15
		level.call_deferred("add_child", new_shrapnel)

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(Vars.base_damage + randi_range(0, Vars.max_random_damage))
		if not Vars.piercing:
			if Vars.explosive:
				explode()
			queue_free()
		elif randi_range(0, 2) == 0:
			if Vars.explosive:
				explode()
			queue_free()
			
	if body.has_method("get_pushed"):
		body.get_pushed(Vector2.from_angle(global_rotation), Vars.impact)
	
