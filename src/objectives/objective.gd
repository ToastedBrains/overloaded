extends Area2D

var player : Node2D

func _ready():
	player = get_parent().get_node("Player")

func _process(delta):
	%Arrow.look_at(%Target.global_position)
	%Arrow.global_position.x = clamp(%Target.global_position.x, player.global_position.x - 350, player.global_position.x + 350)
	%Arrow.global_position.y = clamp(%Target.global_position.y - 50, player.global_position.y - 250, player.global_position.y + 250)

func _on_body_entered(body):
	%Arrow.hide()


func _on_body_exited(body):
	%Arrow.show()
