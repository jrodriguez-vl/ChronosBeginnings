extends RigidBody2D

@export var rotation_range = [10, 200]

var rotation_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_speed = randi_range(rotation_range[0],rotation_range[1])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees = rotation_degrees + (rotation_speed  * delta)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
