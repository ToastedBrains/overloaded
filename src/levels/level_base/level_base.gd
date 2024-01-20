extends Node

signal new_ennemi
signal objective_complete

const ENNEMI = preload("res://src/ennemies/ennemy/ennemy.tscn")
const CHECKPOINT = preload("res://src/objectives/checkpoint/checkpoint.tscn")
const ARTEFACT = preload("res://src/objectives/artefact/artefact.tscn")
const ZONE = preload("res://src/objectives/zone/zone.tscn")
const DETONATOR = preload("res://src/objectives/detonator/detonator.tscn")
const EXIT = preload("res://src/objectives/exit/exit.tscn")

var current_objective : Dictionary
var ennemies = 0
var ennemies_down = 0
var scenario = [
	{
		"type": "kill",
		"amount": 6,
		"text": "Kill 100 worms",
		"success": "Ah good! I love the smell of worms blood in the morning!"
	},
	{
		"type": "go",
		"text": "Go to checkpoint",
		"success": "Pretty simple nop?"
	},
	{
		"type": "pick-up",
		"text": "Now, go find some valuable alien artefact.",
		"success": "Oh, perfect! This stays between us, okay?"
	},
	{
		"type": "capture",
		"text": "Secure the sector 97",
		"success": "Well done, stay close..."
	},
	{
		"type": "active",
		"location": null,
		"text": "Push the button, blow it all up!",
		"success": "Good boy."
	},
	{
		"type" : "fly",
		"text": "Go quick to extraction point!",
		"success": "Good game! Give me that artifact, I'll secure it."
	},
]


func _ready():
	give_objective()
	#%Music.play()
	Debug.print(current_objective)
	#pass


func give_objective():
	Debug.print("Give new objective")
	current_objective = scenario.pop_front()
	await get_tree().create_timer(1).timeout
	%ObjectiveText.text = current_objective["text"]
	%ObjectiveBox.show()
	await get_tree().create_timer(3).timeout
	%ObjectiveBox.hide()
	if current_objective["type"] == "go":
		generate_checkpoint()
	elif current_objective["type"] == "pick-up":
		generate_artefact()
	elif current_objective["type"] == "capture":
		generate_zone()
	elif current_objective["type"] == "active":
		generate_detonator()
	elif current_objective["type"] == "fly":
		generate_exit()

func rand_dist():
	return clamp(randi_range(-5000, 5000), -2000, 2000)


func generate_checkpoint():
	var new_checkpoint = CHECKPOINT.instantiate()
	new_checkpoint.global_position = Vector2(%Player.global_position.x + rand_dist(), %Player.global_position.y + rand_dist())
	new_checkpoint.checkpoint_reached.connect(self._on_checkpoint_reached)
	call_deferred("add_child", new_checkpoint)


func _on_checkpoint_reached():
	%ObjectiveBox.show()
	%ObjectiveText.text = current_objective["success"]
	await get_tree().create_timer(3).timeout
	give_objective()


func generate_artefact():
	var new_artefact = ARTEFACT.instantiate()
	new_artefact.global_position = Vector2(%Player.global_position.x + rand_dist(), %Player.global_position.y + rand_dist())
	new_artefact.artefact_collected.connect(self._on_artefact_collected)
	call_deferred("add_child", new_artefact)


func _on_artefact_collected():
	%ObjectiveBox.show()
	%ObjectiveText.text = current_objective["success"]
	await get_tree().create_timer(3).timeout
	give_objective()


func generate_zone():
	var new_zone = ZONE.instantiate()
	new_zone.global_position = Vector2(%Player.global_position.x + rand_dist(), %Player.global_position.y + rand_dist())
	new_zone.zone_controlled.connect(self._on_zone_controlled)
	Debug.print([new_zone.global_position, scenario[1]])
	scenario[0]["location"] = new_zone.global_position
	call_deferred("add_child", new_zone)


func _on_zone_controlled():
	%ObjectiveBox.show()
	%ObjectiveText.text = current_objective["success"]
	await get_tree().create_timer(3).timeout
	give_objective()
	

func generate_detonator():
	var new_detonator = DETONATOR.instantiate()
	new_detonator.global_position = current_objective["location"]
	new_detonator.bomb_armed.connect(self._on_bomb_armed)
	call_deferred("add_child", new_detonator)


func _on_bomb_armed():
	%ObjectiveBox.show()
	%ObjectiveText.text = current_objective["success"]
	await get_tree().create_timer(3).timeout
	give_objective()

func generate_exit():
	var new_exit = EXIT.instantiate()
	new_exit.global_position = Vector2(%Player.global_position.x + rand_dist(), %Player.global_position.y + rand_dist())
	new_exit.player_teleported.connect(self._on_player_teleported)
	call_deferred("add_child", new_exit)
	

func _on_player_teleported():
	end_game()


func end_game():
	%ObjectiveBox.show()
	%ObjectiveText.text = current_objective["success"]
	await get_tree().create_timer(3).timeout

	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
		
func pause_game():
	if Vars.game_state == Vars.State.PAUSED:
		%Skills.hide_skills()
		Engine.time_scale = 1
		Vars.game_state = Vars.State.PLAYING
	else:
		%Skills.show_skills()
		Engine.time_scale = 0.001
		Vars.game_state = Vars.State.PAUSED


func spawn():
	var new_ennemi = ENNEMI.instantiate()
	new_ennemi.target = %Player
	%PathFollow2D.progress_ratio = randf()
	new_ennemi.global_position = %PathFollow2D.global_position
	new_ennemi.ennemy_down.connect(self._on_ennemy_down)
	call_deferred("add_child", new_ennemi)
	emit_signal("new_ennemi")


func spawn_more():
	%SpawnTimer.wait_time /= 1.1

func _on_spawn_timer_timeout():
	spawn()


func _on_ennemy_down():
	ennemies_down += 1
	ennemies -= 1
	%HUD.update_debug(ennemies, ennemies_down)
	if current_objective["type"] == "kill" and ennemies_down >= current_objective["amount"]:
		emit_signal("objective_complete")
		%ObjectiveText.text = current_objective["success"]
		%ObjectiveBox.show()
		#await get_tree().create_timer(3).timeout
		#%ObjectiveBox.hide()
		give_objective()


func _on_new_ennemi():
	ennemies += 1
	%HUD.update_debug(ennemies, ennemies_down)


func _on_player_player_health_exhausted():
	#Debug.print("Player health = 0")
	pass


func _on_skills_skills_modified():
	#Debug.print("Skills update")
	%Player.update_skills(Vars.skills)
	%HUD.hide_skill_message()


func _on_player_skill_point_earned():
	%Skills.update_points()
	%HUD.show_skill_message()
	spawn_more()

func _on_player_exp_gained():
	%HUD.update_xp()
