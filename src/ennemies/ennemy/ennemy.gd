extends CharacterBody2D

signal ennemy_down

var life = 2
var speed = 200.0
var target : Node2D
var is_pushed = 0

func _process(delta):
	var direction = global_position.direction_to(target.position)
	if is_pushed > 1:
		velocity =  direction * speed * (-is_pushed)
		is_pushed /= 2
	else:
		velocity = direction * speed
		is_pushed = 0
	look_at(target.global_position)
	move_and_slide()


func take_damage():
	life -= 1
	if life <= 0:
		queue_free()
		emit_signal("ennemy_down")

func get_pushed(direction: Vector2, force: float):
	is_pushed = force
