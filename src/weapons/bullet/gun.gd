extends Area2D

var ROF = 8.0 # bullets / second
const BULLET = preload("res://src/weapons/bullet/bullet.tscn")


func _ready():
	Debug.print(%ShootTimer.wait_time)
	%ShootTimer.wait_time = 1 / ROF
	Debug.print(%ShootTimer.wait_time)
	
func _physics_process(delta):
	var ennemis_in_range : Array[Node2D] = get_overlapping_bodies()
	if ennemis_in_range.size() > 0:
		#Debug.print("Ennemy!")
		var target = ennemis_in_range.front()
		#look_at(target.global_position)


func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Cannon.global_position
	new_bullet.global_rotation = %Cannon.global_rotation
	%Cannon.add_child(new_bullet)


func _on_shoot_timer_timeout():
	shoot()
