extends Area2D
class_name HealthComponent

signal Died
signal Knockback

@export var MAX_HEALTH := 10.0
@export var knockbackResistance = 0
@export var canBeKnockedBack = true

var health : float
var parent: CharacterBody2D

func _ready():
	health = MAX_HEALTH


func _process(delta):
	pass

func TakeDamage(dmg: float, knockbackForce: float, knockbackDirection: Vector2):
	if health == 0:
		return

	health = clampf(health - dmg, 0, health)

	Knockback.emit(knockbackForce, knockbackDirection)

	if(health == 0):
		Died.emit()
	
