extends CanvasLayer

var exp_full = false
var last_xp_step = 0
var player : Node

#func _process(_delta):
	#var player = get_parent().get_node("Player")
	
func _ready():
	player = get_parent().get_node("Player")

func show_skill_message():
	%NewSkill.show()


func hide_skill_message():
	%NewSkill.hide()


func update_xp():
	#Debug.print(%ExpBar.value)
	if Vars.xp_steps.size() > 1:
		last_xp_step = Vars.xp_steps[-2]
	#Debug.print(last_exp_step)
	%ExpBar.min_value = last_xp_step
	%ExpBar.max_value = Vars.xp_steps.back()
	%ExpBar.value = Vars.xp
	

func update_debug(ennemis, killed):
	%Debug.text = "Ennemis = {ennemis}\nKilled = {killed}\nHealth = {health}/{health_max}\n".format({
		"ennemis": ennemis,
		"killed": killed,
		"health": player.health,
		"health_max": player.health_max,
	})
