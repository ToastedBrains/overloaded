extends Control

signal skills_modified

var skill_points = 4
var buttons = [TextureButton]
var skills = {
		"dmg1" : false,
		"dmg2" : false,
		"dmg3" : false,
		"dmg5" : false,
		"speed1" : false,
		"speed2" : false,
		"speed3" : false,
		"speed4" : false,
	}

func _ready():
	buttons = get_tree().get_nodes_in_group("buttons")
	for b in buttons:
		b.pressed.connect(_on_skill_button_pressed.bind(b))
	disable_buttons()


func show_skills():
	%CanvasLayer.show()


func hide_skills():
	%CanvasLayer.hide()


func update_points():
	%SkillPointsAvailable.text = str(skill_points)
	disable_buttons()
	read_buttons()


func disable_buttons():
	for b in buttons:
		var parent = b.get_parent()
		if parent in buttons:
			if parent.is_pressed():
				b.disabled = false
			else:
				b.disabled = true
				if b.button_pressed:
					b.button_pressed = false
					skill_points += 1


func _on_skill_button_pressed(button):
	if button.is_pressed():
		if skill_points > 0:
			skill_points -= 1
			var children = button.get_children()
			for c in children:
				c.disabled = false
		else:
			button.button_pressed = false
	else:
		skill_points += 1
		var childs = button.get_children()
		if childs.size() > 0:
			for c in childs:
				if c.is_pressed():
					c.button_pressed = false
					skill_points += 1
	update_points()


func read_buttons():
	Debug.print("Reading buttons")
	for b in buttons:
		if b.button_pressed and b.has_meta("value"):
			Debug.print("There is value")
			var value = b.get_meta("value")
			if value:
				Debug.print(value)
				match value:
					"dmg1":
						Debug.print("dmg1? BUG!!!")
					"speed4":
						Debug.print("Turn speed4 ON")
						skills["speed4"] = true
	emit_signal("skills_modified")

