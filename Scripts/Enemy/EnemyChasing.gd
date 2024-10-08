extends State
class_name EnemyChasing

@export var chaseSpeed = 1

var target: Player
@onready var audio: AudioStreamPlayer2D

func Enter():
	super()
	audio = parentNode.get_node("AudioStreamPlayer2D")
	target = get_tree().get_first_node_in_group("Player")
	animation.play("move")

func Update(_delta):
	if !audio.playing:
		audio.play()

	if !target:
		audio.stop()
		Transition("EnemyPatrolling")
		return

	var distance = parentNode.position.distance_to(target.position)
	if(distance > 100 && !Global.EnemiesAlwaysChase):
		Transition("EnemyPatrolling")
		return

	var movement = parentNode.position.direction_to(target.position) * chaseSpeed
	animation.flip_h = movement.x < 0
	parentNode.position += movement * _delta
