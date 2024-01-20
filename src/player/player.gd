extends CharacterBody2D

signal player_health_exhausted
signal exp_gained
signal skill_point_earned

var speed = 600.0
var health_max = 100.0
var health = health_max
var input = Vector2.ZERO

var dna_give_health = false
var regenerate = false

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

func _process(delta):
	%HealthBar.value = health
	#%Path2D.scale.x = 1 / Vars.spawn_scale.x
	#%Path2D.scale.y = 1 / Vars.spawn_scale.y
	if regenerate:
		health += clamp(1 * delta, 0, health_max)

func _physics_process(delta):
	var aggressors = %Hitbox.get_overlapping_bodies()
	#Debug.print(aggressors.front())
	if aggressors.size() > 0:
		health -= 10 * aggressors.size() * delta
		if health <= 0:
			emit_signal("player_health_exhausted")
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	look_at(global_position + direction)
	move_and_slide()



func _on_collect_zone_area_entered(area):
	if area.is_in_group("dna"):
		area.picked_up(self)
		Vars.xp += 1
		emit_signal("exp_gained")
		if dna_give_health:
			health += clamp(1, 0, health_max)
		if Vars.xp in Vars.xp_steps:
			Vars.skill_points += 1
			emit_signal("skill_point_earned")
			Vars.xp_steps.append(Vars.xp_steps.back() * 2)


func update_skills(skills):
	#Debug.print("Updating skills...")
	if skills["health3"]:
		health_max = 200
	elif skills["health2"]:
		health_max = 150
	elif skills["health1"]:
		health_max = 120
	else:
		health_max = 100
	health = clamp(health, 0, health_max)
	%HealthBar.max_value = health_max
	if skills["health4"]:
		dna_give_health = true
	else:
		dna_give_health = false
	if skills["health5"]:
		regenerate = true
	else:
		regenerate = false
	if skills["speed1"]:
		speed = 720.0
	if skills["speed2"]:
		speed = 900.0
	if skills["speed3"]:
		speed = 1200.0
	if skills["dmg20"]:
		Vars.set_damage(
			Vars.base_damage * 1.2,
			Vars.max_random_damage + 1,
			Vars.impact * 1.2)
	elif skills["dmg50"]:
		Vars.set_damage(
			Vars.base_damage * 1.5,
			Vars.max_random_damage + 3,
			Vars.impact * 1.5)
	elif skills["dmgx2"]:
		Vars.set_damage(
			Vars.base_damage * 2,
			Vars.max_random_damage + 5,
			Vars.impact * 2)
	if skills["rof2"]:
		%Gun.set_rate_of_fire(4.0)
	elif skills["rof3"]:
		%Gun.set_rate_of_fire(8.0)
	if skills["scope"]:
		Vars.set_scope(6000, 1800.0)
	if skills["explosive"]:
		pass
	Vars.piercing = Vars.skills["piercing"]
	Vars.double = Vars.skills["double"]
	Vars.triple = Vars.skills["triple"]
	if skills["arm1"]:
		pass
	if skills["arm2"]:
		pass
	if skills["arm3"]:
		pass
	if skills["armsuper"]:
		pass
