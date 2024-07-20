extends State
class_name EnemyChasing

@export var chaseSpeed = 1

var target: Player

func Enter():
	super()
	target = get_tree().get_first_node_in_group("Player")
	animation.play("move")


func Update(_delta):
	if !target:
		print("no player found")
		Transition("EnemyPatrolling")
		return

	var distance = parentNode.position.distance_to(target.position)
	if(distance > 100):
		print(distance)
		print("too far from player")
		Transition("EnemyPatrolling")
		return

	var movement = parentNode.position.direction_to(target.position) * chaseSpeed
	animation.flip_h = movement.x < 0
	parentNode.position += movement * _delta
