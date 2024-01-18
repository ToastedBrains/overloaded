extends CharacterBody2D

signal ennemy_down

var life = 30
var speed = 200.0
var target : Node2D
var is_pushed = 0

const DNA = preload("res://src/collectibles/dna/dna.tscn")
const DMGTEXT = preload("res://src/ui/hud/messages/damage_pop.tscn")

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


func take_damage(damage):
	%HitSFX1.play()
	life -= damage
	var new_dmgtext = DMGTEXT.instantiate()
	new_dmgtext.global_position = global_position
	new_dmgtext.set_damage_amount(damage)
	get_parent().call_deferred("add_child", new_dmgtext)
	if life <= 0:
		die()
		emit_signal("ennemy_down")

func get_pushed(direction: Vector2, force: float):
	is_pushed = force
