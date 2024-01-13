extends CharacterBody2D

var hitpoints = 3
var speed = 200.0
var target : Node2D

#func _init(player):
	#target = player

func _process(delta):
	var direction = global_position.direction_to(target.position)
	velocity = direction * speed
	look_at(target.global_position)
	move_and_slide()
