extends Area2D
class_name HealthComponent

signal Died

@export var MAX_HEALTH := 10.0

var health : float

func _ready():
	health = MAX_HEALTH

func _process(delta):
	pass

func TakeDamage(dmg: float):
	if health == 0:
		return

	health = clampf(health - dmg, 0, health)

	if(health == 0):
		Died.emit()
