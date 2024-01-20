extends Area2D

var ROF = 2.0 # bullets / second
const BULLET = preload("res://src/weapons/bullet/bullet.tscn")

func set_ammo():
	pass

func set_rate_of_fire(new_rof: float):
	ROF = new_rof
	%ShootTimer.wait_time = 1 / ROF
	
func _ready():
	#Debug.print(%ShootTimer.wait_time)
	%ShootTimer.wait_time = 1 / ROF
	#Debug.print(%ShootTimer.wait_time)
	
func _physics_process(delta):
	#rotation *= 1.1
	
	var ennemis_in_range : Array[Node2D] = get_overlapping_bodies()
	if ennemis_in_range.size() > 0:
		#Debug.print("Ennemy!")
		var target = ennemis_in_range.front()
		#look_at(target.global_position)


func shoot():
	if Vars.skills["double"] or Vars.skills["triple"]:
		var new_bullet_e1 = BULLET.instantiate()
		new_bullet_e1.global_position = %Cannon.global_position
		new_bullet_e1.global_rotation = %Cannon.global_rotation
		new_bullet_e1.global_rotation = %Cannon.global_rotation + 0.1
		%Cannon.add_child(new_bullet_e1)
		var new_bullet_e2 = BULLET.instantiate()
		new_bullet_e2.global_position = %Cannon.global_position
		new_bullet_e2.global_rotation = %Cannon.global_rotation
		new_bullet_e2.global_rotation = %Cannon.global_rotation - 0.1
		%Cannon.add_child(new_bullet_e2)
	if not Vars.skills["double"] or Vars.skills["triple"]:
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Cannon.global_position
		new_bullet.global_rotation = %Cannon.global_rotation
		%Cannon.add_child(new_bullet)
	%ShootSFX.play()

func _on_shoot_timer_timeout():
	shoot()
