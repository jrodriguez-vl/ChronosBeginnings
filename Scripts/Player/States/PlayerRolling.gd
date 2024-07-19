extends State
class_name PlayerRolling

@export var rollSpeed = 200

func Enter():
	super()
	var direction = get_parent().direction
	var animatedSprite = "roll_" + direction
	animation.play(animatedSprite)

func Update(delta):
	if(!animation.is_playing()):
		Transition("Idle")
		return
	parentNode.position += get_parent().directionAxis * rollSpeed * delta

