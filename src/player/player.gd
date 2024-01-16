extends CharacterBody2D

signal player_health_exhausted

const SPEED = 600.0
const HEALTH_MAX = 100.0

var health = HEALTH_MAX
var input = Vector2.ZERO


func _process(_delta):
	%HealthBar.value = health
	#%Path2D.scale.x = 1 / Vars.spawn_scale.x
	#%Path2D.scale.y = 1 / Vars.spawn_scale.y


func _physics_process(delta):
	var aggressors = %Hitbox.get_overlapping_bodies()
	Debug.print(aggressors.front())
	if aggressors.size() > 0:
		health -= 5 * aggressors.size() * delta
		if health <= 0:
			emit_signal("player_health_exhausted")
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	look_at(global_position + direction)
	move_and_slide()

