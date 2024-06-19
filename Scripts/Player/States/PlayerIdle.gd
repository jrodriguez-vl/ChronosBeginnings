extends State
class_name PlayerIdle

func Enter():
	super()
	var direction = get_parent().direction
	var animatedSprite = "idle_" + direction
	animation.play(animatedSprite)


func Update(_delta: float):
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		Transition("Walking")
	elif Input.is_action_just_pressed("roll"):
		Transition("Rolling")
	elif Input.is_action_just_pressed("attack"):
		Transition("Attacking")
	
