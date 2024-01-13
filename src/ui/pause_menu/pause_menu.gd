extends Control


func _process(delta):
	if visible:
		%CanvasLayer.visible = true
	else:
		%CanvasLayer.visible = false
