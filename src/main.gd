extends Node

enum State {OPENING, PLAYING, PAUSED, GAME_OVER}

var game_state = State.OPENING


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
		
func pause_game():
	if game_state == State.PAUSED:
		%PauseMenu.hide()
		Engine.time_scale = 1
		game_state = State.PLAYING
	else:
		%PauseMenu.show()
		Engine.time_scale = 0.2
		game_state = State.PAUSED
