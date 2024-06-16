extends Label


func _ready():
	pass # Replace with function body.

func _process(delta):
	var newText = ""
	var textList = [
		get_parent().get_node("StateMachine").current_state.name,
	]	

	for item in textList:
		newText += item
		newText += "\n"

	newText.erase(newText.length()-1, 1)

	text = newText
