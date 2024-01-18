extends Area2D

signal objective_completed

const TIME_TO_SOLVE = 5.0
var time_remaining : float


func _process(_delta):
	if not %SolveTimer.is_stopped():
		%TimeDisplay.text = "%2.1f" % %SolveTimer.time_left
	else:
		%TimeDisplay.text = "%2.1f" % TIME_TO_SOLVE
	#Debug.print(%SolveTimer.time_left)
	
func _ready():
	%SolveTimer.wait_time = TIME_TO_SOLVE
	Debug.print(%ColorRect.color)

func _on_body_entered(body):
	%SolveTimer.start()
	pass # Replace with function body.


func _on_body_exited(body):
	%SolveTimer.stop()


func _on_solve_timer_timeout():
	emit_signal("objective_completed")
	%ColorRect.color = Color(0, 1, 0, 0.5)
	%SolveTimer.stop()
	%TimeDisplay.hide()
