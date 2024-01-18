extends CharacterBody2D

signal player_health_exhausted
signal exp_gained
signal skill_point_earned

var speed = 600.0
var health_max = 100.0

var health = health_max
var input = Vector2.ZERO


var skills = {
		"health1" : false,
		"health2" : false,
		"health3" : false,
		"health4" : false,
		"health5" : false,
		"speed1" : false,
		"speed2" : false,
		"speed3" : false,
		"speed4" : false,
		"speed5" : false,
	}

func _process(_delta):
	%HealthBar.value = health
	#%Path2D.scale.x = 1 / Vars.spawn_scale.x
	#%Path2D.scale.y = 1 / Vars.spawn_scale.y


func _physics_process(delta):
	var aggressors = %Hitbox.get_overlapping_bodies()
	#Debug.print(aggressors.front())
	if aggressors.size() > 0:
		health -= 5 * aggressors.size() * delta
		if health <= 0:
			emit_signal("player_health_exhausted")
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	look_at(global_position + direction)
	move_and_slide()



func _on_collect_zone_area_entered(area):
	if area.is_in_group("dna"):
		area.picked_up(self)
		Vars.exp += 1
		emit_signal("exp_gained")
		if Vars.exp in Vars.exp_steps:
		#if Vars.exp == Vars.next_exp_step:
			Vars.skill_points += 1
			emit_signal("skill_point_earned")
			Vars.exp_steps.append(Vars.exp_steps.back() * 2)
			#Vars.next_exp_step = Vars.next_exp_step * 2
			#Debug.print(Vars.exp_steps)


func update_skills(skills):
	#Debug.print("Updating skills...")
	for key in skills:
		#Debug.print([key, skills[key]])
		#Debug.print("----------------")
		match key:
			"health1":
				if skills["health1"]:
					#Debug.print("health1")
					pass
			"health2":
				if skills["health2"]:
					#Debug.print("health2")
					pass
			"speed1":
				if skills["speed1"]:
					#Debug.print("speed1")
					pass
			"speed2":
				if skills["speed2"]:
					#Debug.print("speed2")
					pass
