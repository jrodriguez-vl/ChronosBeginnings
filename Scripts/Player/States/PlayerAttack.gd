extends State


func Enter():
	super()
	var direction = get_parent().direction
	var animatedSprite = "attack_" + direction
	animation.play(animatedSprite)

func Update(delta):
	if(!animation.is_playing()):
		Transition("Idle")
		return