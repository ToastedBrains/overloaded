extends Node

func print(args) -> void:
	if not OS.is_debug_build():
		return
	var stack = get_stack()
	if stack.size() > 1:
		stack = stack[1]
	else:
		stack = ["UNKNOWN", "0", "_"]
	var display_string = "[DEBUG] (%s:%s %s) : " % [
				stack["source"].replace("res://", ""),
				str(stack["line"]),
				stack["function"],
			]
	if args is Array:
		print(display_string, "%s %s" % [
			"\n\t\t-",
			"\n\t\t- ".join(args),
		])
	else:
		print(display_string, "%s" % [
			args,
		])
