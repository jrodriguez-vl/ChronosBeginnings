extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var hpComponent = get_node("HealthComponent") as HealthComponent
	if hpComponent :
		hpComponent.Died.connect(die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	queue_free()