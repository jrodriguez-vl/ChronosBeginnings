extends State
class_name PlayerWalking

@export var speed = 100

func Update(_delta):
	var moveDirection = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		moveDirection.y -= 1
		state_machine.direction = "up"
	if Input.is_action_pressed("move_down"):
		moveDirection.y += 1
		state_machine.direction = "down"
	if Input.is_action_pressed("move_right"):
		moveDirection.x += 1
		state_machine.direction = "right"
	if Input.is_action_pressed("move_left"):
		moveDirection.x -= 1
		state_machine.direction = "left"
	
	moveDirection = moveDirection.normalized()
	state_machine.directionAxis = moveDirection
	if Input.is_action_pressed("roll"):
		Transition("Rolling")
		return

	if moveDirection == Vector2.ZERO:
		Transition("Idle")
		return


	moveDirection = moveDirection * speed
	var animationString = determine_animation(moveDirection)
	animation.play(animationString)

	PlayerNode.position += moveDirection * _delta

func Exit():
	animation.stop()

func determine_animation(moveDirection) -> String:
	if moveDirection.x > 0: 
		return "walk_right"

	if moveDirection.x < 0:
		return "walk_left"
	
	if moveDirection.y > 0: 
		return "walk_down"

	return "walk_up"
