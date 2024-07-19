extends State

@export var speed = Vector2(10,20)
@export var secondsToAdjustPatrolRoute: int = 2


var xMov: float
var yMov: float
var moveSpeed: float
var secondsSinceLastCalibration: float
var target: Player

func Enter():
	super()
	recalibrateRoute()
	target = get_tree().get_first_node_in_group("Player")
	animation.play("move")

func Update(_delta):
	patrol(_delta)

func patrol(_delta):
	if secondsSinceLastCalibration > secondsToAdjustPatrolRoute:
		recalibrateRoute()

	var distance = parentNode.position.distance_to(target.position)
	if(distance < 100):
		Transition("Chasing")
		return

	#will need to flip animation if x < 0
	var moveDirection = Vector2(xMov, yMov)
	determineAnimationFLip()
	parentNode.position += moveDirection * moveSpeed * _delta
	secondsSinceLastCalibration += _delta

func recalibrateRoute():
	secondsSinceLastCalibration = 0
	xMov = randf_range(-1,1)
	yMov = randf_range(-1,1)
	moveSpeed = randf_range(speed.x, speed.y)

func determineAnimationFLip():
	animation.flip_h = xMov < 0