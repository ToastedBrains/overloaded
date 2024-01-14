extends Camera2D

var zoom_min = Vector2(.2, .2)
var zoom_max = Vector2(2, 2)
var zoom_speed = Vector2(.05, .05)
var zoom_target = zoom


func _process(delta):
	zoom = lerp(zoom, zoom_target, .2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom_target > zoom_min:
					zoom_target -= zoom_speed
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom_target < zoom_max:
					zoom_target += zoom_speed
