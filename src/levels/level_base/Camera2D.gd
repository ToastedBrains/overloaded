extends Camera2D


var zoom_min = Vector2(.2, .2)
var zoom_max = Vector2(2, 2)
var zoom_speed = Vector2(.05, .05)
var zoom_target = zoom

# ZOOM with mouse wheel is for debug purpose,
# zoom will be handled for special moment

func set_custom_zoom():
	#zoom_target = Vars.zoom
	Vars.zoom = zoom_target
	Vars.spawn_scale = zoom_target
	#Vars.spawn_scale.x = zoom_target
	#Vars.spawn_scale.y = zoom_target
	#Vars.spawn_scale.x = 2.0
	#Vars.spawn_scale.y = 2.0

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
			set_custom_zoom()
