extends Area2D
class_name Player
signal hit

const WALK_UP = "walk_up"
const WALK_DOWN = "walk_down"
const WALK_LEFT = "walk_left"
const WALK_RIGHT = "walk_right"

const ROLL_UP = "roll_up"
const ROLL_DOWN = "roll_down"
const ROLL_LEFT = "roll_left"
const ROLL_RIGHT = "roll_right"

# @export var speed = 100
# @export var rollSpeed = 200

# func start(pos):
	# position = pos
	# show()
	# $CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
	# var moveDirection = Vector2.ZERO
	# var moveVelocity = Vector2.ZERO

	# if Input.is_action_pressed("move_down"):
	# 	moveDirection.x += 1
	# if Input.is_action_pressed("move_left"):
	# 	moveDirection.x -= 1
	# if Input.is_action_pressed("move_up"):
	# 	moveDirection.y -= 1
	# if Input.is_action_pressed("move_down"):
	# 	moveDirection.y += 1
	
	# if moveDirection.length() > 0:
	# 	determine_animation(moveDirection)
	# 	if(player_state == PlayerStates.ROLL):
	# 		moveVelocity = moveDirection.normalized() * rollSpeed
	# 	else: 
	# 		moveVelocity = moveDirection.normalized() * speed
	# 	$AnimatedSprite2D.play()
	# else:
	# 	$AnimatedSprite2D.stop()
	
	# position += moveVelocity * delta


# func determine_animation(moveDirection):
# 	# rolling takes priority over walking
# 	if player_state == PlayerStates.ROLL:
# 		return
	
# 	if moveDirection.x != 0:
# 		if moveDirection.x > 0: 
# 			$AnimatedSprite2D.animation = WALK_RIGHT
# 		elif moveDirection.x < 0:
# 			$AnimatedSprite2D.animation = WALK_LEFT
# 	elif moveDirection.y != 0:
# 		if moveDirection.y > 0: 
# 			$AnimatedSprite2D.animation = WALK_DOWN
# 		elif moveDirection.y < 0:
# 			$AnimatedSprite2D.animation = WALK_UP


# func _on_body_entered(_body):
# 	hide()
# 	hit.emit()
	
# 	#disable the shape at the end of the frame to avoid issues
# 	#with engine collision algos 
# 	$CollisionShape2D.set_deferred("disabled", true)
