extends Control

var skill_points = 4
var buttons = [TextureButton]


func _ready():
	buttons = get_tree().get_nodes_in_group("buttons")
	for b in buttons:
		b.pressed.connect(_on_skill_button_pressed.bind(b))
	disable_buttons()


func updatePoints():
	%SkillPointsAvailable.text = str(skill_points)
	disable_buttons()


func disable_buttons():
	for b in buttons:
		var parent = b.get_parent()
		if parent in buttons:
			if parent.is_pressed():
				b.disabled = false
			else:
				b.disabled = true
				b.button_pressed = false


func _on_skill_button_pressed(button):
	Debug.print(button)
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
	updatePoints()

