extends CanvasLayer

func update_debug(ennemis, killed):
	%Debug.text = "Ennemis = {ennemis}\nKilled = {killed}\n".format({
		"ennemis": ennemis,
		"killed": killed,
	})
