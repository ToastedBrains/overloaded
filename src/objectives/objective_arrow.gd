extends Area2D

@onready var player = get_tree().get_nodes_in_group("player").front()


func _process(delta):
	%Arrow.look_at(%Target.global_position)
	%Arrow.global_position.x = clamp(%Target.global_position.x, player.global_position.x - 350, player.global_position.x + 350)
	%Arrow.global_position.y = clamp(%Target.global_position.y - 50, player.global_position.y - 250, player.global_position.y + 250)
	#%Arrow.global_position.x = clamp(%Target.global_position.x, player.global_position.x - 350, player.global_position.x + 350)
	#%Arrow.global_position.y = clamp(%Target.global_position.y - 50, player.global_position.y - 250, player.global_position.y + 250)

func _on_body_entered(body):
	#%Arrow.hide()
	$AnimationPlayer.play("fade_out")


func _on_body_exited(body):
	#%Arrow.show()
	$AnimationPlayer.play("fade_in")


#func _on_proxi_2_body_entered(body):
	#$AnimationPlayer.play("proxi2")
#
#
#func _on_proxi_2_body_exited(body):
	#pass # Replace with function body.
#
#
#func _on_proxi_1_body_entered(body):
	#$AnimationPlayer.play("proxi1")
#
#
#func _on_proxi_1_body_exited(body):
	#pass # Replace with function body.
