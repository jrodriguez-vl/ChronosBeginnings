extends Label


func _ready():
	pass # Replace with function body.

func _process(_delta):
	var newText = ""
	var stateMachine = get_parent().get_node("StateMachine")
	if !stateMachine:
		return 

	var textList = [
		stateMachine.current_state.name,
	]	

	for item in textList:
		newText += item
		newText += "\n"

	newText.erase(newText.length()-1, 1)

	text = newText
