extends CharacterBody2D

signal player_health_exhausted

var speed = 600.0
const HEALTH_MAX = 100.0

var health = HEALTH_MAX
var input = Vector2.ZERO
var exp = 0
var exp_steps = [3]

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
		exp += 1
		if exp in exp_steps:
			exp_steps.append(exp_steps.back() * 2) 
			Debug.print(exp_steps)


func update_skills(skills):
	Debug.print(skills)
	if skills["speed4"]:
		Debug.print("Gotcha!")
		speed *= 2
