extends CharacterBody2D

signal ennemy_down

var life = 2
var speed = 200.0
var target : Node2D
var is_pushed = 0

const DNA = preload("res://src/collectibles/dna/dna.tscn")


func die():
	#Debug.print("A worm is dead")
	var new_dna = DNA.instantiate()
	new_dna.global_position = global_position
	get_parent().call_deferred("add_child", new_dna)
	queue_free()

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
		die()
		emit_signal("ennemy_down")

func get_pushed(direction: Vector2, force: float):
	is_pushed = force
