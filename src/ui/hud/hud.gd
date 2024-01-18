extends CanvasLayer

var exp_full = false
var last_exp_step = 0


#func _process(_delta):
	#update_xp()


func show_skill_message():
	%NewSkill.show()


func hide_skill_message():
	%NewSkill.hide()


func update_xp():
	#Debug.print(%ExpBar.value)
	if Vars.exp_steps.size() > 1:
		last_exp_step = Vars.exp_steps[-2]
	#Debug.print(last_exp_step)
	%ExpBar.min_value = last_exp_step
	%ExpBar.max_value = Vars.exp_steps.back()
	%ExpBar.value = Vars.exp
	

func update_debug(ennemis, killed):
	%Debug.text = "Ennemis = {ennemis}\nKilled = {killed}\n".format({
		"ennemis": ennemis,
		"killed": killed,
	})
