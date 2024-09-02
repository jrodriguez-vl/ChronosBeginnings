extends State
class_name EnemyPatrolling

@export var speed = Vector2(10,20)
@export var secondsToAdjustPatrolRoute: int = 2


var xMov: float
var yMov: float
var moveSpeed: float
var secondsSinceLastCalibration: float
@onready var target: Player

func Enter():
	super()
	recalibrateRoute()
	target = Global.player
	animation.play("move")

func Update(_delta):
	patrol(_delta)

func patrol(_delta):

	if secondsSinceLastCalibration > secondsToAdjustPatrolRoute:
		recalibrateRoute()

	if(target != null):
		var distance = parentNode.position.distance_to(target.position)
		if(distance < 100):
			Transition("EnemyChasing")
			return

	#will need to flip animation if x < 0
	var moveDirection = Vector2(xMov, yMov)
	determineAnimationFlip()
	parentNode.position += moveDirection * moveSpeed * _delta
	secondsSinceLastCalibration += _delta

func recalibrateRoute():
	secondsSinceLastCalibration = 0
	xMov = randf_range(-1,1)
	yMov = randf_range(-1,1)
	moveSpeed = randf_range(speed.x, speed.y)

func determineAnimationFlip():
	animation.flip_h = xMov < 0
