extends CharacterBody2D

const SPEED = 600
#const ACCELERATION = 1000
#const FRICTION = 600
#const INERTIA = 300

var input = Vector2.ZERO

#func get_input_direction():
	#input.x = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	#input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))


func _process(_delta):
	%Path2D.scale.x = 1 / Vars.spawn_scale.x
	%Path2D.scale.y = 1 / Vars.spawn_scale.y
	#%Path2D.set_scale(Vars.spawn_scale)
	#%Path2D.set_scale(Vector2(2,2))

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	#velocity = direction * lerp(10, SPEED, .4)
	#Debug.print(direction)
	look_at(global_position + direction)
	move_and_slide()
	#if move_and_slide():
		#for collisions in get_slide_collision_count():
			#var collision = get_slide_collision(collisions)
			#if collision.get_collider() is RigidBody2D:
				#collision.get_collider().apply_force(collision.get_normal() * -1500)
