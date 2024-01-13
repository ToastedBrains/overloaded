extends CharacterBody2D

const SPEED = 600

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	#Debug.print(direction)
	look_at(global_position + direction)
	move_and_slide()
