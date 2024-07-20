extends Node2D
class_name BaseEnemy


# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		if child is HealthComponent:
			child.Died.connect(die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	print("supposed to queue free")
	queue_free()
