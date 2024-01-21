extends Area2D

var ROF = 2.0 # bullets / second
var random_rotation = randi_range(0, 180)
const BULLET = preload("res://src/weapons/bullet/bullet.tscn")


func _init():
	global_rotation_degrees += random_rotation


func set_rate_of_fire(new_rof: float):
	ROF = new_rof
	%ShootTimer.wait_time = 1 / ROF


func _ready():
	%ShootTimer.wait_time = 1 / ROF


func _physics_process(delta):
	global_rotation_degrees += 1
	var ennemis_in_range : Array[Node2D] = get_overlapping_bodies()
	if ennemis_in_range.size() > 0:
		var target = ennemis_in_range.front()
		if Vars.arm_super:
			look_at(target.global_position)


func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Cannon.global_position
	new_bullet.global_rotation = %Cannon.global_rotation
	%Cannon.add_child(new_bullet)
	%ShootSFX.play()


func _on_shoot_timer_timeout():
	shoot()
