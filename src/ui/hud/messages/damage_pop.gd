extends Label

func _ready():
	await get_tree().create_timer(0.75).timeout
	queue_free()

func set_damage_amount(value):
	text = str(value)
