extends State
class_name PlayerRolling

@export var rollSpeed = 200

var initiated = false

func Enter():
	super()
	initiated = true
	var direction = get_parent().direction
	var animatedSprite = "roll_" + direction
	animation.play(animatedSprite)

func Update(delta):
	if(!animation.is_playing()):
		Transition("Idle")
		return
	PlayerNode.position += get_parent().directionAxis * rollSpeed * delta

