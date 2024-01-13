extends CharacterBody2D

var life = 3
var speed = 200.0
var target : Node2D


func _process(delta):
	var direction = global_position.direction_to(target.position)
	velocity = direction * speed
	look_at(target.global_position)
	move_and_slide()


func take_damage():
	life -= 1
	if life <= 0:
		queue_free()
